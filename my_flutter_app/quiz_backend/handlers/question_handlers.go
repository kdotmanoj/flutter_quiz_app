package handlers

import (
	"encoding/json"
	"net/http"
)

func GetTotalQuestionsHandler(w http.ResponseWriter, r *http.Request) {
	// Example implementation
	totalQuestions := 10
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(totalQuestions)
}

func GetQuestionHandler(w http.ResponseWriter, r *http.Request) {
	// Example implementation
	question := map[string]interface{}{
		"question": "What is the capital of France?",
		"options":  []string{"Paris", "London"},
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(question)
}

func SubmitAnswerHandler(w http.ResponseWriter, r *http.Request) {
	// Example implementation
	var answer map[string]string
	if err := json.NewDecoder(r.Body).Decode(&answer); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	response := map[string]interface{}{
		"correct": true, // This should be determined based on the answer
		"explanation": "Paris is the capital of France.",
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
