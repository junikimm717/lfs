package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
)

type MimuxClient struct {
	BaseURL string
}

func (c *MimuxClient) sendJson(path string) {
	db, err := ReadPackageDBFromPath(path)
	if err != nil {
		log.Printf("Can't send JSON at %v, %v\n", path, err)
		return
	}
	body, _ := json.Marshal(db)
	request, _ := http.NewRequest(http.MethodPost, c.BaseURL, bytes.NewBuffer(body))
	request.Header.Set("MIMUX_API_KEY", APIKEY)
	request.Header.Set("Content-Type", "application/json")
	resp, err := http.DefaultClient.Do(request)
	if err != nil {
		log.Printf("Got an error requesting from %v: %v\n", c.BaseURL, err)
		return
	}

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Printf("Got an error reading from respBody: %v\n", err)
	}
	fmt.Println("Response:")
	fmt.Println(string(respBody))
}

func (c *MimuxClient) deleteRequest(keys []string) {
	body, _ := json.Marshal(keys)
	request, _ := http.NewRequest(http.MethodPost, c.BaseURL, bytes.NewBuffer(body))
	request.Header.Set("MIMUX_API_KEY", APIKEY)
	request.Header.Set("Content-Type", "application/json")
	resp, err := http.DefaultClient.Do(request)
	if err != nil {
		log.Printf(
			"Got an error requesting from %v: %v\n",
			c.BaseURL+"/delete",
			err,
		)
		return
	}

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Printf("Got an error reading from respBody: %v\n", err)
	}
	fmt.Println("Response:")
	fmt.Println(string(respBody))
}
