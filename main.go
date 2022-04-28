package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
)

func main() {
	dict := map[string]string{}
	for _, element := range os.Environ() {
		variable := strings.Split(element, "=")
		key := variable[0]
		value := variable[1]
		dict[key] = value
	}

	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		writer.Header().Set("Content-Type", "application/json")
		json.NewEncoder(writer).Encode(dict)
	})

	port, found := os.LookupEnv("PORT")

	if !found {
		port = "8080"
	}
	port = fmt.Sprintf(":%s", port)

	http.ListenAndServe(port, nil)
}
