//
//  QuestionnaireNavigationView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct QuestionnaireNavigationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showBewegungSheet = false
    @State private var showLebensqualitaetSheet = false
    @State private var showSymptomatikSheet = false
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text("Fragebögen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
           
            LazyVGrid (columns: columns, spacing: 20) {
               
                Button(action: {
                    showBewegungSheet = true
                }) {
                    NavigationTile(imageSystemName: "list.bullet.clipboard", title: "Bewegung")
                }
                .sheet(isPresented: $showBewegungSheet) {
                    PDQView()
                }
                
                Button(action: {
                    showLebensqualitaetSheet = true
                }) {
                    NavigationTile(imageSystemName: "list.bullet.clipboard", title: "Lebensqualität")
                }
                .sheet(isPresented: $showBewegungSheet) {
                    Text("Lebensqualität")
                }
                
                Button(action: {
                    showSymptomatikSheet = true
                }) {
                    NavigationTile(imageSystemName: "list.bullet.clipboard", title: "Symptomatik")
                }
                .sheet(isPresented: $showBewegungSheet) {
                    Text("Symptomatik")
                }
            }
            .padding()
        }
    }
}

#Preview {
    QuestionnaireNavigationView()
}
