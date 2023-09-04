package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"

	vosk "github.com/alphacep/vosk-api/go"
)

func main() {

	model, err := vosk.NewModel("model")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(model)
	// we can check if word is in the vocabulary
	// fmt.Println(model.FindWord("air"))

	sampleRate := 47000.0
	rec, err := vosk.NewRecognizer(model, sampleRate)
	if err != nil {
		log.Fatal(err)
	}
	rec.SetWords(1)
	fmt.Println(rec)

	file, err := os.Open("./test.mp3")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	buf := make([]byte, 4096)

	for {
		_, err := file.Read(buf)
		if err != nil {
			if err != io.EOF {
				log.Fatal(err)
			}

			break
		}

		if rec.AcceptWaveform(buf) != 0 {
			fmt.Println(rec.Result())
		}
	}
	fmt.Println(rec.FinalResult)
	// Unmarshal example for final result
	var jres map[string]interface{}
	json.Unmarshal([]byte(rec.FinalResult()), &jres)
	fmt.Printf("text: %s\n", jres)
}
