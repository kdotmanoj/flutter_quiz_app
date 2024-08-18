package handlers

import (
	"encoding/json"
	"net/http"
)

// GetTotalQuestionsHandler handles requests to get the total number of questions.
func GetTotalQuestionsHandler(w http.ResponseWriter, r *http.Request) {
	totalQuestions := 10 // Example total number of questions
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]int{"total": totalQuestions})
}

// GetQuestionHandler handles requests to get a question.
func GetQuestionHandler(w http.ResponseWriter, r *http.Request) {
	question := map[string]interface{}{
		"question": "What is the capital of France?",
		"options":  []string{"Paris", "London"},
		"hint":     "It's known as the City of Light.",
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(question)
}

// SubmitAnswerHandler handles requests to submit an answer.
func SubmitAnswerHandler(w http.ResponseWriter, r *http.Request) {
	var answer map[string]string
	if err := json.NewDecoder(r.Body).Decode(&answer); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	correct := answer["answer"] == "Paris" // Example logic for checking answer
	response := map[string]interface{}{
		"correct":     correct,
		"explanation": "Paris is the capital of France.",
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
