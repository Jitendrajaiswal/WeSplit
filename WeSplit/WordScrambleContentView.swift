//
//  WordScrambleContentView.swift
//  WeSplit
//
//  Created by Jaiswal, Jitendra on 28/05/24.
//

import SwiftUI

struct WordScrambleContentView: View {
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Please enter the new word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    
                    ForEach(usedWord, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart Game", action: restartGame)
            }
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: startgame)
            .alert(errorTitle, isPresented: $showingError){
                Button("OK"){}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func restartGame() {
        usedWord.removeAll()
        newWord = ""
        startgame()
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isLengthOk(word: answer) else {
            errorTitle = "word too short"
            errorMessage = "ohh! Try making word which contains more than 2 letters"
            showingError = true
            return
        }
        
        guard isNotStartingWord(word: answer) else {
            errorTitle = "word too easy"
            errorMessage = "You can't make a starting word it's too easy"
            showingError = true
            return
        }
        
        guard isOriginal(word: answer) else {
            errorTitle = "Word used already"
            errorMessage = "Be more specific"
            showingError = true
            return
        }
        
        guard isPossible(word: answer) else {
            errorTitle = "word not possible"
            errorMessage = "You can't spell \(answer) using '\(rootWord)'!"
            showingError = true
            return
        }
        
        guard isReal(word: answer) else {
            errorTitle = "Word not recognized"
            errorMessage = "You can't just make them up, you know!"
            showingError = true
            return
        }
        
        withAnimation {
            usedWord.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startgame() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
          if let startWordString = try? String(contentsOf: startWordURL) {
              let allWords = startWordString.components(separatedBy: "\n")
              
              rootWord = allWords.randomElement() ?? "silkworm"
              
              return
            }
        }
        
        fatalError("Unable to load start.txt")
    }
    
    func isOriginal(word: String)-> Bool {
        !usedWord.contains(word)
    }
    
    func isPossible(word: String)-> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return mispelledRange.location == NSNotFound
    }
    
    func isLengthOk(word: String) -> Bool {
        return word.count > 2 || rootWord.hasPrefix(word)
    }
    
    func isNotStartingWord(word: String) -> Bool {
        return !rootWord.hasPrefix(word)
    }
}

#Preview {
    WordScrambleContentView()
}
