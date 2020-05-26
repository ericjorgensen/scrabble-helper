//
//  ContentView.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 4/27/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import SwiftUI

struct DictionaryView: View {
    
    // An instance of the DictionaryManager class that loads the dictionary.
    let dictionaryManager = DictionaryManager()
    
    // The word the player is searching the dictionary for.
    @State private var searchWord: String = ""
    
    // Whether or not a match is found in the dictionary for the searched word.
    @State private var wordMatchFound: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Word Lookup")
                .font(.headline)
                .bold()
                .padding(.bottom)
            TextField("Enter word", text: $searchWord).modifier(ClearButton(searchWord: $searchWord, wordMatchFound: $wordMatchFound))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(wordMatchFound ? Color.green : Color.red, width: 2)
                .disableAutocorrection(true)
                .animation(.easeInOut)
                
            HStack {
                Button(action: {
                    // Searches dictionary for the word (uppercased, since our dictionary is uppercased and trimming spaces)
                    if ( self.dictionaryManager.searchDictionaryForWord(word: self.searchWord) ) {
                        self.wordMatchFound = true
                    } else {
                        
                    }
                }) {
                    Text("Search")
                }
            }
            .alert(isPresented: $wordMatchFound) {
                Alert(title: Text("Dictionary Search"), message: Text("It's a word!"), dismissButton: .default(Text("Cool")))
            }
        }.padding()
    }
}

struct ScoreKeeper: View {
    
    // Init scorekeeping variables
    @State private var playerOneScore: Double = 0.0
    @State private var playerOneScoreIncrement = 0.0
    @State private var playerTwoScore: Double = 0.0
    @State private var playerTwoScoreIncrement: Double = 0.0
    
    let playerOneScoreTracker = ScoreTracker()
    let playerTwoScoreTracker = ScoreTracker()
    
    // A variable to hold the scores that we want to display in the modal
    @State private var modalScores : [Score] = []
    
    // Score modal
    @State private var scoreModalIsShown: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Score Keeper")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
            }.padding(.top)
            
            HStack {
                VStack {
                    Text("Player One Score")
                    Text(String(playerOneScore))
                        .bold()
                    Slider(value: $playerOneScoreIncrement, in: 1.0...100.0, step: 1)
                    HStack{
                        Text("Score to add:")
                        Text(String(playerOneScoreIncrement))
                    }
                    
                    HStack {
                        Button(action: {
                            // Add the entry from the text field to Player One's score
                            self.playerOneScoreTracker.scores.append(Score(value: self.playerOneScoreIncrement))
                            self.playerOneScore = self.playerOneScoreTracker.getScore()
                        }) {
                            Text("Add")
                        }
                        
                        Button(action: {
                            self.scoreModalIsShown = true
                            self.modalScores = self.playerOneScoreTracker.scores
                        }) {
                            Text("View Scores")
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Player Two Score")
                    Text(String(playerTwoScore))
                    .bold()
                    Slider(value: $playerTwoScoreIncrement, in: 1.0...100.0, step: 1)
                    Text(String(playerTwoScoreIncrement))
                        
                        HStack {
                            Button(action: {
                                // Add the entry from the text field to Player One's score
                                self.playerTwoScoreTracker.scores.append(Score(value:self.playerTwoScoreIncrement))
                                self.playerTwoScore = self.playerTwoScoreTracker.getScore()
                            }) {
                                Text("Add")
                            }
                            
                            Button(action: {
                               self.scoreModalIsShown = true
                               self.modalScores = self.playerTwoScoreTracker.scores
                            }) {
                                Text("View Scores")
                            }
                        }
                }
            }
            
        }.padding()
        .sheet(isPresented: self.$scoreModalIsShown) {
            ScoreModalView(modalScores: self.$modalScores)
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            DictionaryView()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Dictionary")
                }
            ScoreKeeper()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Scores")
                }
        }
        
    }
}

struct ClearButton: ViewModifier {
    
    @Binding var searchWord: String
    @Binding var wordMatchFound: Bool
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            
            content
            
            if ( !searchWord.isEmpty ) {
                Button(action: {
                    self.searchWord = ""
                    self.wordMatchFound = false
                }) {
                    Image(systemName: "delete.left")
                    .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
            
        }
    }
}

struct ScoreModalView: View {
    
    @Binding var modalScores: [Score]
    
    var body: some View {
        List(modalScores) { score in
                Text(String(score.value))
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
