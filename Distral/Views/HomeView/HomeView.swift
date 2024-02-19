//
//  HomeView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTest: TestNavigation = .questionnaires
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hallo")
                .font(.callout)
                .padding()
            Text("Max Mustermann")
                .font(.title)
                .padding()
            
            Picker("Test Optionen", selection: $selectedTest){
                ForEach(TestNavigation.allCases) {test in
                    Text(test.displayName).tag(test)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                if selectedTest.tutorial.title == "Fragebögen" {
                    QuestionnaireNavigationView()
                } else if selectedTest.tutorial.title == "Stroop" {
                    Text("Stroop View")
                } else if selectedTest.tutorial.title == "Motorik" {
                    Text("Motorik View")
                }
                
                Text("Wie funktioniert es?")
                    .font(.headline)
                    .padding()
                
                TutorialCellView(title: selectedTest.tutorial.title, text: selectedTest.tutorial.text, videoName: selectedTest.tutorial.videoName)
                
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
