//
//  PDQView.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import SwiftUI

struct PDQView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = PDQ8ViewModel()
    var title: String = ""
    @State private var currentQuestionIndex: Int = 0
    @State private var backToHome: Bool = false
    
    var body: some View {
        if !viewModel.isQuestionnaireCompleted {
            questionView
        }
    }
    
    var questionView: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Button("", systemImage: "arrow.backward", action: viewModel.moveThroughQuestionsBackward)
                        .font(.title)
                    
                    Text("Frage: \(viewModel.questionCounter + 1) / 8")
                        .font(.system(size: 20))
                        .padding()
                    
                    Button("", systemImage: "arrow.forward", action: viewModel.moveThroughQuestionsForward)
                        .font(.title)
                }
                
                ScrollView {
                    Text(viewModel.titles[viewModel.questionCounter] ?? "")
                        .font(.title3)
                        .padding()
                }
                
                // Buttons für die Antwortoptionen
                VStack(spacing: 5) {
                    ForEach(0..<5, id: \.self) { option in
                        Button(action: {
                            viewModel.selectOption(option)
                        }) {
                            HStack {
                                Text(answerText(for: option))
                                    .frame(maxWidth: .infinity)
                                    .font(.headline)
                                Spacer()
                                if isOptionSelected(option) {
                                    Image(systemName:"checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .foregroundStyle(Color.black)
                            .overlay (
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(isOptionSelected(option) ? Color.blue : Color.white, lineWidth: 5)
                            )
                            .cornerRadius(12)
                        }
                        .padding(10)
                    }
                    
                    Button(action: {
                        viewModel.moveThroughQuestionsForward()
                    }) {
                        Text("Weiter")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                    .padding()
                }
            }
            .background(.gray.opacity(0.14))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {dismiss()}) {
                        Image(systemName: "x.circle")
                        .foregroundStyle(.gray)
                    }
                }
            }
        }
        //        .overlay(
        //            viewModel.showAlertForUnansweredQuestion ? CustomAlertView(showAlert: $viewModel.showAlertForUnansweredQuestion) : nil
        //        )
    }
    
    func isOptionSelected(_ option: Int) -> Bool {
        return viewModel.selectedOptions[viewModel.questionCounter] == option
    }
    
    func answerText(for option: Int) -> String {
        switch option {
        case 0: return "Trifft gar nicht zu"
        case 1: return "Trifft eher zu"
        case 2: return "Trifft teilweise zu"
        case 3: return "Trifft überwiegend zu"
        case 4: return "Trifft voll zu"
        default: return ""
        }
    }
}

#Preview {
    PDQView()
}
