package main

import (
	"encoding/json"
	"net/http"
	"quiz-app/models"
)

func HandleGetQuestions(w http.ResponseWriter, r *http.Request) {
	difficulty := r.URL.Query().Get("difficulty")
	questions := FetchQuestionsByDifficulty(difficulty)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(questions)
}

func HandleSubmitAnswers(w http.ResponseWriter, r *http.Request) {
	var submission struct {
		Difficulty string   `json:"difficulty"`
		Answers    []string `json:"answers"`
	}
	json.NewDecoder(r.Body).Decode(&submission)
	// Process submission
	w.WriteHeader(http.StatusOK)
}

func FetchQuestionsByDifficulty(difficulty string) []models.Question {
	// Mock data, should be fetched from the database
	return []models.Question{
        {
            Text:          "What is 2 + 2?",
            Options:       []string{"3", "4", "5"},
            CorrectAnswer: "4",
            Explanation:   "2 + 2 equals 4.", // Explanation added here
        },
        {
            Text:          "What is the capital of France?",
            Options:       []string{"Berlin", "Madrid", "Paris"},
            CorrectAnswer: "Paris",
            Explanation:   "The capital of France is Paris.", // Explanation added here
        },
        // Add more questions with explanations as needed
    }
}
