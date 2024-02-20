//
//  ProfileView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct ProfileView: View {
    @State private var id_gkv: String = ""
    @State private var users: [User] = []
    @Environment(\.managedObjectContext) var managedObjectContext
    var databaseService: DatabaseService
    
    var body: some View {
        VStack {
            Form {
                TextField("ID GKV", text: $id_gkv)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Benutzer hinzufügen") {
                    databaseService.addUser(id_gkv: id_gkv)
                    users = databaseService.fetchUsers()
                }
                .padding()
            }
            List {
                ForEach(users, id: \.self) {user in
                    Text(user.id_gkv ?? "Unbekannt")
                }
                .onDelete(perform: deleteUser)
            }
        }
    }
    
    private func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            databaseService.deleteUser(withIDGKV: user.id_gkv!)
        }
        users = databaseService.fetchUsers()
    }
}

//#Preview {
//    ProfileView()
//}
