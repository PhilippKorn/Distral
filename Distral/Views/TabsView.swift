//
//  TabsView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI
import CoreData

struct TabsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
           
            ProfileView(databaseService: DatabaseService(context: managedObjectContext))
                .tabItem {
                    Label("Profil", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    TabsView()
}
