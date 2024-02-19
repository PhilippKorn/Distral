//
//  PDQView.swift
//  Distral
//
//  Created by Philipp Korn on 19.02.24.
//

import SwiftUI

struct PDQView: View {
    @ObservedObject var viewModel = PDQ8ViewModel()
    var title: String = ""
    @State private var currentQuestionIndex: Int = 0
    @State private var backToHome: Bool = false
   
    var body: some View {
        if !viewModel.isQuestionnaireCompleted {
            // vew while Questions are shown
                questionView
        }
    }
    
    var questionView: some View {
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
                    .font(.headline)
                    .padding()
            }
            
            // Buttons für die Antwortoptionen
            VStack(spacing: 30) {
                ForEach(0..<5, id: \.self) { option in
                    Button(action: {
                        viewModel.selectOption(option)
                        viewModel.moveThroughQuestionsForward()
                    }) {
                        Text(answerText(for: option))
                            .font(.system(size: 25))
                            .frame(width: 310, height: 60)
                            .background(isOptionSelected(option) ? Color("Impala_steel") : Color("Impala_beige"))
                            .foregroundStyle(isOptionSelected(option) ? .white : .black)
                            .cornerRadius(10)
                    }
                    .padding(10)
                }
            }
        }
//        .overlay(
//            viewModel.showAlertForUnansweredQuestion ? CustomAlertView(showAlert: $viewModel.showAlertForUnansweredQuestion) : nil
//        )
//        .onAppear{
//            print(databaseService.fetchAllPDQ8Results())
//        }
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
