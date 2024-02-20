//
//  FHIRService.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import Foundation
import ModelsR4

struct FHIRService {
    static func convertToPatient(user: User) -> Patient {
        let patient = Patient()
        let identifier = Identifier(value: FHIRPrimitive(FHIRString(user.id_gkv ?? "")))
        patient.identifier = [identifier]
        return patient
    }
    
    func showFHIRData(fhirPatient: Patient){
        do {
            let jsonData = try JSONEncoder().encode(fhirPatient)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString ?? "Ungültige Daten")
        } catch {
            print("Fehler bei der Konvertierung")
        }
        
    }
}
