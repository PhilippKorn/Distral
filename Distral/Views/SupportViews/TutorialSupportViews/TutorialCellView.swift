//
//  TutorialCellView.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import SwiftUI

struct TutorialCellView: View {
   
    var title: String
    var text: String
    var videoName: String
    @State private var showDetail = false // Um das Sheet anzugeigen
    
    var body: some View {
        HStack {
            // Profilbild
            Image("Impi2PDF")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding()
            
            VStack {
                Text(title)
                    .font(.headline)
                Text(text)
                    .font(.subheadline)
            }
            
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding()
        }
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            self.showDetail = true
        }
        .sheet(isPresented: $showDetail) {
            TutorialDetailView(videoName: videoName, title: title, text: text)
        }
    }
}

#Preview {
    TutorialCellView(title: "TestName", text: "Beispieltext", videoName: "")
}
