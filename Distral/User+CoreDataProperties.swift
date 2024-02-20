//
//  User+CoreDataProperties.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//
//

import Foundation
import CoreData
import ModelsR4


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var id_gkv: String?

}

extension User : Identifiable {

}

extension User {
    public func toFHIRPatient() -> Patient {
        var patient = Patient()
        let identifier = Identifier(use: .official, value: FHIRPrimitive(FHIRString(self.id_gkv ?? "")))
        patient.identifier = [identifier]
        print(patient)
        return patient
    }
}
