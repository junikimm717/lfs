package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

type MimuxServer struct {
	server   *http.Server
	mux      *http.ServeMux
	Port     int
	Data ServerData
	SavePath string
}

// struct for data to be sent to https://img.shields.io/endpoint
type BadgeData struct {
	SchemaVersion int    `json:"schemaVersion"`
	Label         string `json:"label"`
	Message       string `json:"message"`
	Color         string `json:"color"`
	IsError       bool   `json:"isError"`
}

func (m *MimuxServer) authenticate(r *http.Request) bool {
	correctKey := APIKEY
	// WHAT why does the capitalization get auto adjusted :/
	supplied := r.Header["Mimux-Api-Key"]
	authorized := len(supplied) > 0 && supplied[0] == correctKey
	return authorized
}

// 초기화때만 사용됨
func ReadServerDataFromPath(savePath string) (*ServerData, error) {
	body, err := os.ReadFile(savePath)
	if err != nil {
		return nil, err
	}
	data := &ServerData{}
	err = json.Unmarshal(body, &data)
	if err != nil {
		return nil, err
	}
	if data.LastUpdated == 0 {
		return nil, errors.New("LastUpdated is zero, maybe we're on a legacy format.")
	}

	validationErrors := []string{}
	for key := range data.Packages {
		if len(data.Packages[key].Current) == 0 {
			validationErrors = append(validationErrors, fmt.Sprintf(
				"field \"%v\" lacks a field current", key,
			))
		}
		if len(data.Packages[key].Latest) == 0 {
			validationErrors = append(validationErrors, fmt.Sprintf(
				"field \"%v\" lacks a field latest", key,
			))
		}
	}

	if len(validationErrors) > 0 {
		return nil, errors.New(
			strings.Join(validationErrors, "\n"),
		)
	}
	if err != nil {
		return nil, err
	}
	return data, nil
}


func (m *MimuxServer) readSave() {
	db, err := ReadServerDataFromPath(m.SavePath)
	if err != nil {
		log.Printf("Starting with empty package DB. Failed to read in package db at %v: %v\n", m.SavePath, err.Error())
		return
	}
	m.Data = *db
}

func (m *MimuxServer) writeSave() {
	// this is where we get last updated stuff going.
	m.Data.LastUpdated = time.Now().UnixMilli()
	body, err := json.Marshal(m.Data)
	if err != nil {
		panic("Impossible. m.packages must always be marshalable")
	}
	err = os.WriteFile(m.SavePath, body, 0644)
	if err != nil {
		log.Printf("Failed to save package db to %v: %v\n", m.SavePath, err)
	}
}

func (m *MimuxServer) handleJson(w http.ResponseWriter, r *http.Request) {
	if len(r.Method) == 0 || r.Method == http.MethodGet {
		data, err := json.Marshal(m.Data.Packages)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			log.Println("Got an error from unmarshalling json:", err)
			return
		}
		w.Header().Add("Content-Type", "application/json")
		w.Write(data)
	} else {
		w.WriteHeader(http.StatusNotFound)
	}
}

func (m *MimuxServer) handleRoot(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodGet {
		m.renderFrontPage(w)
	} else if r.Method == http.MethodPost {
		// failed authentication logic
		if !m.authenticate(r) {
			w.WriteHeader(http.StatusUnauthorized)
			w.Write([]byte("You are not authorized to access this endpoint."))
			return
		}

		r.Body = http.MaxBytesReader(w, r.Body, 1<<20)
		body, err := io.ReadAll(r.Body)
		if err != nil {
			log.Println("Got an error from reading in request body:", err)
			w.WriteHeader(http.StatusBadRequest)
			return
		}

		data, err := ReadPackageDB(body)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
			log.Println("Got an error from reading in packagedb json in body:", err)
			return
		}
		for key := range *data {
			m.Data.Packages[key] = (*data)[key]
		}
		m.writeSave()
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Ok Updated"))
	}
}

func (m *MimuxServer) handleDel(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		w.WriteHeader(http.StatusNotFound)
		return
	}
	if !m.authenticate(r) {
		w.WriteHeader(http.StatusUnauthorized)
		w.Write([]byte("You are not authorized to access this endpoint."))
		return
	}
	body, err := io.ReadAll(r.Body)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println("Got an error from reading in request body:", err)
		return
	}

	data := DeleteRequest{}
	err = json.Unmarshal(body, &data)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println("Got an error from reading in request json in body:", err)
		return
	}

	messages := make([]string, 0, 5)
	for _, key := range data {
		if _, ok := m.Data.Packages[key]; !ok {
			messages = append(messages, fmt.Sprintf("%v not found", key))
		} else {
			delete(m.Data.Packages, key)
		}
	}
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Ok Deleted\n" + strings.Join(messages, "\n")))
}

func (m *MimuxServer) getUpdated() UpdatedInfo {
	res := UpdatedInfo{}
	for key, _ := range m.Data.Packages {
		res.Total++
		if m.Data.Packages[key].Latest == m.Data.Packages[key].Current {
			res.UpToDate++
		}
	}
	return res
}

func (m *MimuxServer) handleBadge(w http.ResponseWriter, r *http.Request) {
	info := m.getUpdated()
	badge := BadgeData{
		SchemaVersion: 1,
		Label:         "Mimux Core",
		Message:       "Up to Date",
		Color:         "green",
	}
	if info.Total > info.UpToDate {
		badge.Color = "red"
		badge.Message = fmt.Sprintf(
			"%v/%v Out of Date",
			info.Total-info.UpToDate,
			info.Total,
		)
		badge.IsError = true
	}
	data, _ := json.Marshal(badge)
	w.Header().Add("Content-Type", "application/json")
	w.Write(data)
}

func InitMimuxServer(port int, savePath string) MimuxServer {
	m := MimuxServer{}
	m.Data = ServerData{
		LastUpdated: time.Now().UnixMilli(),
		Packages: make(PackageDB),
	}
	m.SavePath = savePath
	m.mux = http.NewServeMux()
	m.server = &http.Server{
		Addr:              ":" + strconv.Itoa(port),
		Handler:           m.mux,
		ReadHeaderTimeout: 5 * time.Second,
		ReadTimeout:       10 * time.Second,
		WriteTimeout:      15 * time.Second,
		IdleTimeout:       60 * time.Second,
	}
	m.Port = port

	m.readSave()
	m.mux.HandleFunc("/", m.handleRoot)
	m.mux.HandleFunc("/json", m.handleJson)
	m.mux.HandleFunc("/badge", m.handleBadge)
	m.mux.HandleFunc("/delete", m.handleDel)

	return m
}

func (m *MimuxServer) Serve() {
	log.Printf("Mimux Server serving from :%v with save path at %v...\n", m.Port, m.SavePath)
	m.server.ListenAndServe()
}
