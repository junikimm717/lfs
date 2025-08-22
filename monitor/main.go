package main

import (
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/spf13/cobra"
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
	serveCmd := &cobra.Command{
		Use: "serve",
		Run: func(cmd *cobra.Command, args []string) {
			port, _ := cmd.Flags().GetInt("port")
			savePath, _ := cmd.Flags().GetString("save")
			server := InitMimuxServer(port, savePath)
			server.Serve()
		},
	}
	serveCmd.Flags().IntP("port", "P", 1434, "Port to use")
	serveCmd.Flags().StringP("save", "S", "/tmp/mimuxserver_save.json", "Where the mimux server should expect to load and save package saves")

	clientCmd := &cobra.Command{
		Use: "send",
		Run: func(cmd *cobra.Command, args []string) {
			path, _ := cmd.Flags().GetString("path")
			baseUrl, _ := cmd.Flags().GetString("baseurl")
			if len(path) == 0 || len(baseUrl) == 0 {
				fmt.Println("You must provide a nonempty base url and save path.")
				os.Exit(1)
			}
			client := MimuxClient{BaseURL: baseUrl}
			client.sendJson(path)
		},
	}
	clientCmd.Flags().StringP("path", "P", "", "Where the save json file is located")
	clientCmd.Flags().StringP(
		"baseurl",
		"U",
		os.Getenv("MIMUX_BASE_URL"),
		"What the base url for sending mimux requests is (default `$MIMUX_BASE_URL`)",
	)

	root := &cobra.Command{
		Use:   "mimuxserver",
		Short: "Utilities for the mimux server",
	}
	root.AddCommand(serveCmd, clientCmd)
	root.Execute()
}
