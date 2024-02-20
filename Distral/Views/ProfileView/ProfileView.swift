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
    @Binding var isUserLoggedIn: Bool
    @State private var currentUser: User?
    
    var body: some View {
        NavigationStack {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {logout()}) {
                        Text("Ausloggen")
                            .foregroundStyle(.black)
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .onAppear {
            users = databaseService.fetchUsers()
            showFHIRPatient()
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
    
    private func logout(){
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userIdentification")
        isUserLoggedIn = false
    }
    
    private func showFHIRPatient() {
        if let id_gkv = UserDefaults.standard.string(forKey: "userIdentification"),
           let user = databaseService.fetchUser(withIDGKV: id_gkv) {
            let fhirPatient = FHIRService.convertToPatient(user: user)
            print(fhirPatient)
            do {
                let jsonData = try JSONEncoder().encode(fhirPatient)
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString ?? "Ungültige Daten")
            } catch {
                print("Fehler bei der Konvertierung: \(error)")
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
