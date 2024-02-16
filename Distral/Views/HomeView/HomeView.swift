//
//  HomeView.swift
//  Distral
//
//  Created by Philipp Korn on 16.02.24.
//

import SwiftUI

struct HomeView: View {
    @State private var auswahl = "Fragebögen"
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hallo")
                .font(.callout)
                .padding()
            Text("Max Mustermann")
                .font(.title)
                .padding()
            
            Picker("Optionen", selection: $auswahl) {
                Text("Fragebögen").tag("Fragebögen")
                Text("Stroop").tag("Stroop")
                Text("Motorik").tag("Motorik")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                if auswahl == "Fragebögen" {
                    QuestionnaireNavigationView()
                } else if auswahl == "Stroop" {
                    Text("Stroop View")
                } else if auswahl == "Motorik" {
                    Text("Motorik View")
                }
                
                Text("Wie funktioniert es?")
                    .font(.headline)
                    .padding()
                
                HStack {
                    // Profilbild
                    Image("Impi2PDF")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding()
                    
                    VStack {
                        Text("Navigation Title")
                            .font(.headline)
                        Text("Navigation Text")
                            .font(.subheadline)
                    }
                    
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .padding()
                }
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            }
            .padding()
            
        }
    }
}

#Preview {
    HomeView()
}
