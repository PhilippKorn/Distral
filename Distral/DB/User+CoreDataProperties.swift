//
//  User+CoreDataProperties.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var id_gkv: String?

}

extension User : Identifiable {

}
