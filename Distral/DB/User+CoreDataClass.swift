//
//  User+CoreDataClass.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//
//

import Foundation
import CoreData
import ModelsR4

@objc(User)
public class User: NSManagedObject {

}
extension User {
    public func toFHIRPatient() -> Patient {
        var patient = Patient()
        let identifier = Identifier(use: .official, value: FHIRPrimitive(FHIRString(self.id_gkv ?? "")))
        patient.identifier = [identifier]
        return patient
    }
}
