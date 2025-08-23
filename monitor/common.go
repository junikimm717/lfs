package main

import (
	"os"
)

type PackageDB map[string]struct {
	Current string `json:"current"`
	Latest  string `json:"latest"`
}

type UpdatedInfo struct {
	UpToDate int
	Total    int
}

type DeleteRequest []string

// 초기화때만 사용됨
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
