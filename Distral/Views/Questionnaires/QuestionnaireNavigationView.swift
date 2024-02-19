//
//  QuestionnaireNavigationView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct QuestionnaireNavigationView: View {
    @Environment(\.presentationMode) var presentationMode
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text("Fragebögen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
           
            LazyVGrid (columns: columns, spacing: 20) {
                NavigationTile(imageSystemName: "list.bullet.clipboard", title: "Bewegung", destination: Text("Bewegung"))
                NavigationTile(imageSystemName: "heart", title: "Lebensqualität", destination: Text("PDQ-8"))
                NavigationTile(imageSystemName: "circle.hexagongrid", title: "Symptomatik", destination: Text("Quality"))
            }
            .padding()
        }
    }
}

#Preview {
    QuestionnaireNavigationView()
}
