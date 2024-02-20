//
//  ProfileView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct ProfileView: View {
    @State private var isGKVScanned = false
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
                    databaseService.addUser(id_gkv: id_gkv) { success in
                        if success {
                            print("Userangelegt")
                        } else {
                            print("LoginView: Anlegen des users hat nicht funktioniert")
                        }
                    }
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
        .onAppear {
            users = databaseService.fetchUsers()
        }
    }
}

extension ProfileView {
    private func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            // Überprüfe, ob der zu löschende User der aktuell eingeloggte User ist
            if let currentUserId = UserDefaults.standard.string(forKey: "userIdentification"),
               currentUserId == user.id_gkv {
                // Setze den Login-Status zurück
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                UserDefaults.standard.removeObject(forKey: "userIdentification")
            }
            databaseService.deleteUser(withIDGKV: user.id_gkv!)
        }
        users = databaseService.fetchUsers()
    }
}

//#Preview {
//    ProfileView()
//}
