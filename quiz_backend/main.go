package main

import (
    "encoding/json"
    "net/http"
)

// Updated question structure with explanation
var questions = []map[string]interface{}{
    {
        "question": "What is the speed of light?",
        "options":  []string{"300,000 km/s", "150,000 km/s", "500,000 km/s", "1,000,000 km/s"},
        "answer":   "300,000 km/s",
        "explanation": "The speed of light in a vacuum is approximately 300,000 kilometers per second (km/s). This fundamental constant is crucial in the field of physics, particularly in understanding the behavior of light and the structure of the universe.",
        "imageUrl": "https://imgs.search.brave.com/ZfY5xlcQtmVKx9KFPzzedr1UO140VVdBTcMYS-1bZBA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuZnJlZWltYWdl/cy5jb20vaW1hZ2Vz/L2xhcmdlLXByZXZp/ZXdzLzhiMi9sb3Rz/LW9mLWxpZ2h0cy1j/cmF6eS1waG90by0x/MTc5ODgyLmpwZz9m/bXQ",
    },
    {
        "question": "What is the name of the galaxy we live in?",
        "options":  []string{"Andromeda", "Milky Way", "Triangulum", "Messier 87"},
        "answer":   "Milky Way",
        "explanation": "The Milky Way is the galaxy that contains our solar system. It is a barred spiral galaxy and is one of billions of galaxies in the universe. Its name is derived from the appearance of its bright, dense core as seen from Earth.",
        "imageUrl": "https://imgs.search.brave.com/QTcDJFaB0Qkp66erkdduPxoHNzPR8G19LncRg8-q4to/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTA0/NzIyOTUzOC9waG90/by9taWxreS13YXku/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PUdLV0JhZ1RxZXVX/V19UU3lzMVQ4T1VH/YW5JUWlPZk5EamN6/dWwtbm9kUTA9",
    },
    {
        "question": "What is the main ingredient in traditional Japanese miso soup?",
        "options":  []string{"Soybean", "Tofu", "Seaweed", "Rice"},
        "answer":   "Soybean",
        "explanation": "Traditional Japanese miso soup is primarily made from miso paste, which is produced by fermenting soybeans with salt and a specific type of mold. Soybeans are the key ingredient that provides the soup its distinct flavor and nutritional benefits.",
        "imageUrl": "https://imgs.search.brave.com/Y-SKG2q5bMkBpDYkM-kZ9SO6qvb3m7scsUdFUbEzPe4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/anVzdG9uZWNvb2ti/b29rLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMi8wOC9D/b2xkLU1pc28tU291/cC1IaXlhamlydS05/Mjk4LUlJLmpwZw",
    },
    {
        "question": "What is the hardest known material on the Mohs scale of mineral hardness?",
        "options":  []string{"Quartz", "Diamond", "Topaz", "Corundum"},
        "answer":   "Diamond",
        "explanation": "On the Mohs scale of mineral hardness, diamond ranks at the highest level, a 10. This scale measures the ability of a mineral to resist scratching by another substance, and diamond's hardness makes it the hardest naturally occurring material.",
        "imageUrl": "https://www.kwunion.com/wp-content/uploads/2017/11/HITTING-HARD-1024x678.jpg",
    },
    {
        "question": "What is the name of the phenomenon where the Earth's magnetic field flips?",
        "options":  []string{"Geomagnetic reversal", "Solar flare", "Aurora borealis", "Solar wind"},
        "answer":   "Geomagnetic reversal",
        "explanation": "A geomagnetic reversal is a process where the Earth's magnetic field reverses direction. This means that the magnetic north and south poles switch places. These reversals occur irregularly throughout Earth's history and can last thousands to millions of years.",
        "imageUrl": "https://gumlet.assettype.com/down-to-earth/import/library/large/2021-02-19/0.40030900_1613738877_magnetic-field.jpg?w=1200&h=675&auto=format%2Ccompress&fit=max&enlarge=true",
    },
    {
        "question": "Which artist is famous for the sculpture 'David'?",
        "options":  []string{"Michelangelo", "Donatello", "Leonardo da Vinci", "Raphael"},
        "answer":   "Michelangelo",
        "explanation": "Michelangelo, the renowned Italian Renaissance artist, sculpted the statue of David between 1501 and 1504. This masterpiece is celebrated for its detailed portrayal of the biblical hero David and is considered one of the greatest works of Renaissance sculpture.",
        "imageUrl": "https://t4.ftcdn.net/jpg/06/41/61/39/360_F_641613980_LWUPKhhDEwoHocmzWVMf5ePdjiidRnuw.jpg",
    },
    {
        "question": "What is the chemical formula for table salt?",
        "options":  []string{"NaCl", "KCl", "MgSO4", "CaCO3"},
        "answer":   "NaCl",
        "explanation": "Table salt is chemically known as sodium chloride, with the formula NaCl. It consists of one sodium (Na) atom and one chlorine (Cl) atom bonded together. Sodium chloride is commonly used in cooking and food preservation.",
        "imageUrl": "https://static.toiimg.com/photo/64385370.cms",
    },
    {
        "question": "What is the name of the first artificial satellite to orbit Earth?",
        "options":  []string{"Voyager 1", "Hubble Space Telescope", "Sputnik 1", "Apollo 11"},
        "answer":   "Sputnik 1",
        "explanation": "Sputnik 1 was the first artificial satellite to successfully orbit the Earth. Launched by the Soviet Union on October 4, 1957, it marked the beginning of the space age and initiated the space race between the USA and USSR.",
        "imageUrl": "https://www.geospatialworld.net/wp-content/uploads/2023/05/catagory_satellite_banner.jpg",
    },
    {
        "question": "Which planet is known as the Red Planet?",
        "options":  []string{"Venus", "Mars", "Jupiter", "Saturn"},
        "answer":   "Mars",
        "explanation": "Mars is often referred to as the Red Planet due to its reddish appearance, which is the result of iron oxide (rust) on its surface. This distinctive color makes Mars one of the most recognizable objects in the night sky.",
        "imageUrl": "https://imageio.forbes.com/specials-images/imageserve/62b362eaddfe029bd27a1f0b/Mars/960x0.jpg?format=jpg&width=960",
    },
    {
        "question": "What is the powerhouse of the cell?",
        "options":  []string{"Nucleus", "Mitochondria", "Ribosome", "Endoplasmic reticulum"},
        "answer":   "Mitochondria",
        "explanation": "Mitochondria are often called the 'powerhouse of the cell' because they generate most of the cell's supply of adenosine triphosphate (ATP), which is used as a source of chemical energy. They play a crucial role in energy production and metabolism.",
        "imageUrl": "https://biomedicalodyssey.blogs.hopkinsmedicine.org/files/2019/10/anatomical-structure-animal-cell-GettyImages-514218370.jpg",
    },
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
