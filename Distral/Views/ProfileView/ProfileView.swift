//
//  ProfileView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct ProfileView: View {
   
    @State private var id_gkv: String = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    var databaseService: DatabaseService
    
    var body: some View {
        Form {
            TextField("ID GKV", text: $id_gkv)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Benutzer hinzufügen") {
                databaseService.addUser(id_gkv: id_gkv)
            }
            .padding()
        }
        .onAppear{
            print("\(databaseService.fetchUsers())")
        }
    }
}

//#Preview {
//    ProfileView()
//}
