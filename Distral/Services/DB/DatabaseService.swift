//
//  DatabaseService.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import Foundation
import CoreData

class DatabaseService {
    let managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
}

// MARK: - User DB Operations

extension DatabaseService {
    func addUser(id_gkv: String, completion: @escaping (Bool) -> Void) {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as! User
        user.id_gkv = id_gkv

        do {
            try managedObjectContext.save()
            print("User erfolgreich gespeichert.")
            completion(true)
        } catch {
            print("Fehler beim Speichern des Users: \(error)")
            completion(false)
        }
    }
   
    func fetchUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching Data: \(error)")
            return []
        }
    }
    
    func deleteUser(withIDGKV idGKV: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id_gkv == %@", idGKV)
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            if let userToDelete = users.first {
                managedObjectContext.delete(userToDelete)
                saveContext()
            }
        } catch {
            print("Fehler beim Löschen des Users: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func userExits(with idGKV: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id_gkv == %@", idGKV)
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            print("DBService: User gefunden: \(result)")
            return !result.isEmpty
        } catch {
            print("Fehler beim Überprüfen des Users \(error)")
            return false
        }
    }
}
