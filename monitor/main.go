package main

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var APIKEY string

func init() {
	// we do not care about whether godotenv fails.
	godotenv.Load()
	APIKEY = os.Getenv("MIMUX_API_KEY")
	if len(APIKEY) == 0 {
		log.Fatal("You may not have an empty MIMUX_API_KEY variable")
	}
}

func main() {
}
