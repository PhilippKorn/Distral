//
//  PDQ8ViewModel.swift
//  Impala
//
//  Created by Sonja Wattendorf on 06.11.23.
//

import Foundation
import SwiftUI
import Combine

struct PDQ8Question {
    let id: Int
    let text: String
}

class PDQ8ViewModel: ObservableObject {
    
    @Published var isQuestionnaireCompleted = false
    
    @Published var pdnmsSliderValues: [Double] = Array(repeating: 0, count: 30)
    
    @Published var currentQuestionIndex: Int = 0
    
    @Published var selectedOptions: [Int?] = Array(repeating: nil, count: 8)
    
    @Published var savePDQ8DataArray = [Int]()
    
    @Published var questionCounter = 0
    
    @Published var showAlertForUnansweredQuestion = false

    
    let titles: [Int: String] = [
        0: "Durch die Symptome meiner Parkinson-Erkrankung hatte ich im letzten Monat große Probleme, mich selbstständig anzuziehen.",
        1: "Im letzten Monat habe ich durch meine Parkinson-Erkrankung eine eingeschränkte Konzentration in alltäglichen Beschäftigungen wie Fernsehen, Rätseln oder Lesen bemerkt.",
        2: "Im letzten Monat habe ich aufgrund meiner Parkinson-Erkrankung viele konflikthafte Situationen mit Personen in meinem engen Umfeld gehabt.",
        3: "Bedingt durch meine Parkinson-Erkrankung habe ich im letzten Monat starke Kommunikations- und Verständigungsprobleme im Gespräch mit anderen Personen verspürt.",
        4: "Im letzten Monat war ich stets in einer deprimierten und gedrückten Stimmung.",
        5: "Aufgrund meiner Parkinson-Erkrankung war es für mich im letzten Monat schwierig, die gewohnte häusliche Umgebung zu verlassen.",
        6: "Durch meine Parkinson-Erkrankung habe ich im letzten Monat aus Scham Tätigkeiten außerhalb meiner gewohnten häuslichen Umgebung wie einen Cafébesuch oder Einkaufen gemieden.",
        7: "Im letzten Monat hatte ich mit schmerzhaften Muskelkrämpfen zu kämpfen.",
    ]
    
    var questions: [Int: PDQ8Question] = [:]

    func previousQuestion(){
        if currentQuestionIndex < titles.count - 1 {
            currentQuestionIndex -= 1
        } else if currentQuestionIndex <= 0 {
            currentQuestionIndex = 0
        }
    }
    
    func selectOption(_ option: Int) {
        selectedOptions[questionCounter] = option
    }
    
    func moveThroughQuestionsForward(){
        if questionCounter < titles.count - 1 {
            if let _ = selectedOptions[questionCounter] {
                questionCounter += 1
            } else {
                showAlertForUnansweredQuestion = true
            }
        } else if questionCounter >= titles.count - 1 {
            isQuestionnaireCompleted = true
        }
    }
    
    func resetQuestionnaire() {
        currentQuestionIndex = 0
        isQuestionnaireCompleted = false
        selectedOptions = Array(repeating: nil, count: 8)
    }
    
    func finishQuestionnaire(){
        let _ = calculateScore()
        isQuestionnaireCompleted = true
        resetQuestionnaire()
    }
    
    func moveThroughQuestionsBackward(){
        if questionCounter >= 1 {
           questionCounter -= 1
        }
    }
    
    func calculateScore() -> Int {
        return 0
    }
}

