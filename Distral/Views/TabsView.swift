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
    @State var selectedTab: Tab
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
           
            ProfileView(databaseService: DatabaseService(context: managedObjectContext), isUserLoggedIn: $isUserLoggedIn)
                .tabItem {
                    Label("Profil", systemImage: "person.circle")
                }
                .tag(Tab.profile)
        }
    }
}
