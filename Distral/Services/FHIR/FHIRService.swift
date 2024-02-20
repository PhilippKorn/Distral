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
        var patient = Patient()
        let identifier = Identifier(value: FHIRPrimitive(FHIRString(user.id_gkv ?? "")))
        patient.identifier = [identifier]
        return patient
    }
}
