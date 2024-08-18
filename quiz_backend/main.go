package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"quiz_backend/handlers"
)

func main() {
    r := mux.NewRouter()

    // Define routes
    r.HandleFunc("/total-questions", handlers.GetTotalQuestionsHandler).Methods("GET")
    r.HandleFunc("/question", handlers.GetQuestionHandler).Methods("GET")
    r.HandleFunc("/submit", handlers.SubmitAnswerHandler).Methods("POST")

    fmt.Println("Server is running on port 35971")
    log.Fatal(http.ListenAndServe("0.0.0.0:35971", r)) // Bind to all interfaces
}


