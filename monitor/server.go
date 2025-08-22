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
	packages PackageDB
	SavePath string
}

func (m *MimuxServer) authenticate(r *http.Request) bool {
	correctKey := APIKEY
	supplied := r.Header["MIMUX_API_KEY"]
	return len(supplied) > 0 && supplied[0] == correctKey
}

func (m *MimuxServer) readSave() {
	db, err := ReadPackageDBFromPath(m.SavePath)
	if err != nil {
		log.Printf("Starting with empty package DB. Failed to read in package db at %v: %v\n", m.SavePath, err.Error())
		return
	}
	m.packages = *db
}

func (m *MimuxServer) writeSave() {
	body, err := json.Marshal(m.packages)
	if err != nil {
		panic("Impossible. m.packages must always be marshalable")
	}
	err = os.WriteFile(m.SavePath, body, 0644)
	if err != nil {
		log.Printf("Failed to save package db to %v: %v\n", m.SavePath, err)
	}
}

func ReadPackageDB(body []byte) (*PackageDB, error) {
	data := PackageDB{}
	err := json.Unmarshal(body, &data)
	if err != nil {
		return nil, err
	}

	validationErrors := []string{}
	for key := range data {
		if len(data[key].Current) == 0 {
			validationErrors = append(validationErrors, fmt.Sprintf(
				"field \"%v\" lacks a field current", key,
			))
		}
		if len(data[key].Latest) == 0 {
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
	return &data, nil
}

func (m *MimuxServer) handleJson(w http.ResponseWriter, r *http.Request) {
	if len(r.Method) == 0 || r.Method == http.MethodGet {
		data, err := json.Marshal(m.packages)
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
	if r.Method == "POST" {
		// failed authentication logic
		if !m.authenticate(r) {
			w.WriteHeader(http.StatusUnauthorized)
			return
		}

		body, err := io.ReadAll(r.Response.Body)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			log.Println("Got an error from reading in request body:", err)
			return
		}

		data, err := ReadPackageDB(body)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte(err.Error()))
			log.Println("Got an error from reading in packagedb json in body:", err)
		}
		for key := range *data {
			m.packages[key] = (*data)[key]
		}
		m.writeSave()
		w.WriteHeader(http.StatusOK)
	}
}

func (m *MimuxServer) handleDel(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		w.WriteHeader(http.StatusNotFound)
		return
	}
	if !m.authenticate(r) {
		w.WriteHeader(http.StatusUnauthorized)
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

	for _, key := range data {
		delete(m.packages, key)
	}
	w.WriteHeader(http.StatusOK)
}

func (m *MimuxServer) getUpdated() UpdatedInfo {
	res := UpdatedInfo{}
	for key, _ := range m.packages {
		res.Total++
		if m.packages[key].Latest == m.packages[key].Current {
			res.UpToDate++
		}
	}
	return res
}

func InitMimuxServer(port int, savePath string) MimuxServer {
	m := MimuxServer{}
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
	m.mux.HandleFunc("/delete", m.handleDel)

	return m
}

func (m *MimuxServer) Serve() {
	log.Printf("Mimux Server serving from :%v with save path at %v...\n", m.Port, m.SavePath)
	m.server.ListenAndServe()
}
