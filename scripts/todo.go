package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
)

const configFile = ".config/todoist/config.json"
const apiURL = "https://api.todoist.com/rest/v2/tasks"

type Config struct {
	Token string `json:"token"`
}

type Task struct {
	ID      string `json:"id"`
	Content string `json:"content"`
}

func getToken() (string, error) {
	home, err := os.UserHomeDir()
	if err != nil {
		return "", err
	}
	path := fmt.Sprintf("%s/%s", home, configFile)
	file, err := os.Open(path)
	if err != nil {
		return "", err
	}
	defer file.Close()

	var cfg Config
	if err := json.NewDecoder(file).Decode(&cfg); err != nil {
		return "", err
	}
	return cfg.Token, nil
}

func listTasks(token, filter string) {
	client := &http.Client{}
	req, _ := http.NewRequest("GET", apiURL, nil)
	
q := req.URL.Query()
	q.Add("filter", filter)
	req.URL.RawQuery = q.Encode()

	req.Header.Add("Authorization", "Bearer "+token)

	resp, err := client.Do(req)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		body, _ := io.ReadAll(resp.Body)
		fmt.Fprintf(os.Stderr, "API Error (%d): %s\n", resp.StatusCode, string(body))
		os.Exit(1)
	}

	var tasks []Task
	if err := json.NewDecoder(resp.Body).Decode(&tasks); err != nil {
		fmt.Fprintf(os.Stderr, "JSON Error: %v\n", err)
		os.Exit(1)
	}

	for _, t := range tasks {
		// Replace newlines to keep it one line per task
		content := strings.ReplaceAll(t.Content, "\n", " ")
		// Print ID [TAB] Content
		fmt.Printf("%s\t%s\n", t.ID, content)
	}
}

func closeTask(token, id string) {
	client := &http.Client{}
	closeURL := fmt.Sprintf("%s/%s/close", apiURL, id)
	req, _ := http.NewRequest("POST", closeURL, nil)
	req.Header.Add("Authorization", "Bearer "+token)

	resp, err := client.Do(req)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		return // Don't exit, so other tasks might still close
	}
	defer resp.Body.Close()

	if resp.StatusCode != 204 {
		body, _ := io.ReadAll(resp.Body)
		fmt.Fprintf(os.Stderr, "Failed to close %s (%d): %s\n", id, resp.StatusCode, string(body))
	} else {
		fmt.Printf("Closed task %s\n", id)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: todo-go list <filter> | close <id>")
		os.Exit(1)
	}

	token, err := getToken()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Config Error: %v\n", err)
		os.Exit(1)
	}

	cmd := os.Args[1]

	switch cmd {
	case "list":
		filter := "today | overdue | inbox"
		if len(os.Args) > 2 {
			filter = os.Args[2]
		}
		listTasks(token, filter)
	case "close":
		if len(os.Args) > 2 {
			closeTask(token, os.Args[2])
		}
	default:
		fmt.Fprintf(os.Stderr, "Unknown command: %s\n", cmd)
		os.Exit(1)
	}
}
