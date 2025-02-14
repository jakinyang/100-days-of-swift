//
//  ContentView.swift
//  WordScramble
//
//  Created by Jae Chun Yang on 2024-12-12.
//

//if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
//    // we found the file in our bundle!
//    if let fileContents = try? String(contentsOf: fileURL) {
//        // we loaded the file into a string!
//    }
//}
//
//
//
//let input = "  a b c  "
//let letters = input.components(separatedBy: " ")
//let random = input.randomElement()
//let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
//let word = "swift"
//let checker = UITextChecker()
//let range = NSRange(location: 0, length: word.utf16.count)
//let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
//
//let allGood = misspelledRange.location == NSNotFound

import SwiftUI
struct ContentView: View {
    @State private var usedWords: [String] = [String]()
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    
//    Alert States to show result of invalid word
    @State private var showingError: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let checker = UITextChecker()
    
    var score: Int {
        var accumulator: Int = 0
        for word in usedWords {
            accumulator += 1
            accumulator += word.count
        }
        return accumulator
    }
    
    func startGame() {
//        Find start.txt in our bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //          Load it into a string
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                //        Split that string into array of strings, with each element being one word
                let allWords = startWords.components(separatedBy: "\n")
                //        Pick one random word from there to be assigned to rootWord, or use a sensible default if the array is empty.
                rootWord = allWords.randomElement() ?? allWords[0]
                return
            }
        }
        
//      Throw fatal error if start.txt does not load
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord(word: String) {
        //        Lowercase newWord and remove any whitespace
        let input = word.lowercased()
        
        //        Check that it has at least 1 character otherwise exit
        guard input.count > 0 else { return }
        
        guard isOriginal(word: word) else {
            showWordError(title: "Word used already", message: "You can't use the same word twice!")
            return
        }
        
        guard isPossible(word: word) else {
            showWordError(title: "Word not possible", message: "Hmmm... I don't think that word is possible here...")
            return
        }
        
        guard isReal(word: word) else {
            showWordError(title: "Not a word", message: "Oops! That doesn't apppear to be a real word.")
            return
        }
        
        guard isStartWord(word: word) else {
            showWordError(title: "That's the root word!", message: "Oh no you don't! You can't just use the root word!")
            return
        }
        
        guard isTooShort(word: word) else {
            showWordError(title: "Too short!", message: "Try to make words longer than 2 letters!")
            return
        }
        
//        Insert that word at position 0 in the usedWords array
        withAnimation {
            usedWords.insert(word, at: 0)
        }
        
//        Set newWord back to be an empty string
        newWord = ""
    }
    
//    is the word original (it hasn’t been used already)
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
//    is the word possible (they aren’t trying to spell “car” from “silkworm”)
    func isPossible(word: String) -> Bool {
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
    
//    is the word real (it’s an actual English word)
    func isReal(word: String) -> Bool {
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
        
        return allGood
    }
    
    func isStartWord(word: String) -> Bool {
        if word == rootWord {
            return false
        } else {
            return true
        }
    }
    
    func isTooShort(word: String) -> Bool {
        if word.count <= 2 {
            return false
        } else {
            return true
        }
    }
    
//    make showing error messages easier
    func showWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        newWord = ""
    }
    
    var body: some View {
        NavigationStack{
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .onSubmit {
                            addNewWord(word: newWord)
                        }
                        .onAppear(perform: startGame)
                        .textInputAutocapitalization(.never)
                        .alert(errorTitle, isPresented: $showingError) {
                            Button("Ok") {}
                        } message: {
                            Text(errorMessage)
                        }
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }

                    }
                }
                Section {
                    Text("Your Score is \(score)")
                }
            }
            .navigationTitle(rootWord)
        }
    }
}

#Preview {
    ContentView()
}
