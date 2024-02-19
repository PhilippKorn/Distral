//
//  TutorialNavigation.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import Foundation
enum TestNavigation: String, CaseIterable, Identifiable {
    case questionnaires
    case motoric
    case stroop

    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .questionnaires:
            return("Fragebögen")
        case .motoric:
            return("Motorik")
        case .stroop:
            return("Stroop")
        }
    }
    
    var tutorial: (title: String, text: String, videoName: String){
        switch self {
        case .questionnaires:
            return("Fragebögen","Tutorial für Fragebögen ansehen","")
        case .motoric:
            return("Motorik","Tutorial für Motorik ansehen","Sequenz04")
        case .stroop:
            return("Stroop","Tutorial für Stroop ansehen","")
        }
    }
}
