package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"strings"
)

type PackageDB map[string]struct {
	Current string `json:"current"`
	Latest  string `json:"latest"`
}

type ServerData struct {
	Packages    PackageDB
	LastUpdated int64
}

type UpdatedInfo struct {
	UpToDate int
	Total    int
}

type DeleteRequest []string

func ReadPackageDBFromPath(savePath string) (*PackageDB, error) {
	body, err := os.ReadFile(savePath)
	if err != nil {
		return nil, err
	}
	db, err := ReadPackageDB(body)
	if err != nil {
		return nil, err
	}
	return db, nil
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
