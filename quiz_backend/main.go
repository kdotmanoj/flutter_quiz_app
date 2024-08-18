package main

import (
    "encoding/json"
    "net/http"
)

// Updated question structure with explanation
var questions = []map[string]interface{}{
    {
        "question": "What is the capital of France?",
        "options":  []string{"Berlin", "Madrid", "Paris", "Lisbon"},
        "answer":   "Paris",
        "explanation": "The capital of France is Paris.",
    },
    {
        "question": "What is the largest planet in our solar system?",
        "options":  []string{"Earth", "Jupiter", "Saturn", "Mars"},
        "answer":   "Jupiter",
        "explanation": "Jupiter is the largest planet in our solar system.",
    },
    {
        "question": "Who wrote 'To Kill a Mockingbird'?",
        "options":  []string{"Harper Lee", "J.K. Rowling", "Ernest Hemingway", "Mark Twain"},
        "answer":   "Harper Lee",
        "explanation": "Harper Lee is the author of 'To Kill a Mockingbird'.",
    },
//     {
//         "question": "What is the chemical symbol for gold?",
//         "options":  []string{"Au", "Ag", "Pb", "Fe"},
//         "answer":   "Au",
//         "explanation": "The chemical symbol for gold is Au.",
//     },
//     {
//         "question": "Which element has the atomic number 1?",
//         "options":  []string{"Oxygen", "Hydrogen", "Helium", "Carbon"},
//         "answer":   "Hydrogen",
//         "explanation": "Hydrogen has the atomic number 1.",
//     },
//     {
//         "question": "What is the smallest prime number?",
//         "options":  []string{"0", "1", "2", "3"},
//         "answer":   "2",
//         "explanation": "2 is the smallest prime number.",
//     },
//     {
//         "question": "What year did the Titanic sink?",
//         "options":  []string{"1912", "1905", "1898", "1923"},
//         "answer":   "1912",
//         "explanation": "The Titanic sank in 1912.",
//     },
//     {
//         "question": "What is the powerhouse of the cell?",
//         "options":  []string{"Nucleus", "Mitochondria", "Ribosome", "Endoplasmic Reticulum"},
//         "answer":   "Mitochondria",
//         "explanation": "The mitochondria is known as the powerhouse of the cell.",
//     },
//     {
//         "question": "What is the hardest natural substance on Earth?",
//         "options":  []string{"Gold", "Iron", "Diamond", "Platinum"},
//         "answer":   "Diamond",
//         "explanation": "Diamond is the hardest natural substance on Earth.",
//     },
//     {
//         "question": "Who painted the Mona Lisa?",
//         "options":  []string{"Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso", "Claude Monet"},
//         "answer":   "Leonardo da Vinci",
//         "explanation": "Leonardo da Vinci painted the Mona Lisa.",
//     },
}

func InitializeRoutes() *http.ServeMux {
    mux := http.NewServeMux()
    mux.HandleFunc("/questions", HandleGetQuestions)
    mux.HandleFunc("/submit", HandleSubmitAnswers)
    return mux
}

// Handler for GET /questions
func HandleGetQuestions(w http.ResponseWriter, r *http.Request) {
    if r.Method == http.MethodGet {
        w.Header().Set("Access-Control-Allow-Origin", "*")
        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(questions)
    } else {
        http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
    }
}

// Handler for POST /submit
type AnswerSubmission struct {
    Difficulty string   `json:"difficulty"`
    Answers    []string `json:"answers"`
}

func HandleSubmitAnswers(w http.ResponseWriter, r *http.Request) {
    if r.Method == http.MethodPost {
        var submission AnswerSubmission
        if err := json.NewDecoder(r.Body).Decode(&submission); err != nil {
            http.Error(w, "Bad request: "+err.Error(), http.StatusBadRequest)
            return
        }
        // Process the answer here and return a response
        w.WriteHeader(http.StatusOK)
        w.Write([]byte("Answer received"))
    } else {
        http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
    }
}

func main() {
    mux := InitializeRoutes()
    http.ListenAndServe(":8080", mux)
}
