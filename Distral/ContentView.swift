//
//  ContentView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var isUserLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    @State private var showTabsView: Bool = false
    
    var body: some View {
        if isUserLoggedIn {
            TabsView(selectedTab: .home)
        } else {
            LoginView(databaseService: DatabaseService(context: managedObjectContext), showTabsView: $showTabsView, isUserLoggedIn: $isUserLoggedIn)
        }
    }
}

#Preview {
    ContentView()
}
