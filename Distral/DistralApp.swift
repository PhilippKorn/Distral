//
//  DistralApp.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

@main
struct DistralApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
