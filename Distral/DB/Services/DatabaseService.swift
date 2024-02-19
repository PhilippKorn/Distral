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
    
    func addUser(id_gkv: String){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as! User
        user.id_gkv = id_gkv
        
        saveContext()
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
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
