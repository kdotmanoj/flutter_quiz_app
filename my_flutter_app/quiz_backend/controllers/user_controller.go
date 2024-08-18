package main

import (
	"encoding/json"
	"net/http"
)

func HandleGetUserData(w http.ResponseWriter, r *http.Request) {
	user := map[string]interface{}{
		"totalPoints": 1000,
		"unlockedLevels": map[string]bool{
			"Easy":   true,
			"Medium": true,
			"Hard":   false,
		},
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(user)
}
