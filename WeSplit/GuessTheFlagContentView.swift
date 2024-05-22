//
//  GuessTheFlagContentView.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 22/05/24.
//

import SwiftUI

struct GuessTheFlagContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State  private var validateAnswerAlert = false
    @State private var showFinalScoreAlert = false
    @State  private var scoreTitle: String = ""
    @State private var flagSelected: String = ""
    @State private var score = 0
    let maxQuestionLimit = 8
    @ State var currentQuestion = 1
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                
            ],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                                .clipShape(.capsule)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Text("Your score is \(score)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                    .foregroundColor(.white)
                Text(" \(currentQuestion)/\(maxQuestionLimit)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            }.padding()
        }
            .alert(scoreTitle, isPresented: $validateAnswerAlert) {
                Button("Continue") {
                    askNewQuestion()
                }
            } message: {
                if scoreTitle == "Correct" {
                    Text("Great! you selected correct flag.")
                } else {
                    Text("ohh! you selected flag of \(flagSelected).")
                }
            }
            .alert("Your total score \(score)", isPresented: $showFinalScoreAlert){
                Button("Restart", action: restartGame)
            } message: {
                Text("Restart you game")
            }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        flagSelected = countries[number]
        validateAnswerAlert = true
    }
    
    func askNewQuestion() {
        if currentQuestion < maxQuestionLimit {
            currentQuestion += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            showFinalScoreAlert = true
        }
    }
    
    func restartGame(){
        score = 0
        currentQuestion = 0
        askNewQuestion()
    }
}

#Preview {
    GuessTheFlagContentView()
}
