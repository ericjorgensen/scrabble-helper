//
//  ContentView.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 4/27/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // The word the player is searching the dictionary for.
    @State private var searchWord: String = ""
    
    // Whether or not a match is found in the dictionary for the searched word.
    @State private var wordMatchFound: Bool = false
    
    @State private var playerOneScore: Int = 0
    @State private var playerOneScoreIncrement: Int = 0
    
    @State private var playerTwoScore: Int = 0
    @State private var playerTwoScoreIncrement: Int = 0
    
    
    // An instance of the DictionaryManager class that loads the dictionary.
    let dictionaryManager = DictionaryManager()
    
    let playerOneScoreTracker = ScoreTracker()
    let playerTwoScoreTracker = ScoreTracker()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Word Lookup")
                .font(.callout)
                .bold()
            TextField("Enter word", text: $searchWord).modifier(ClearButton(searchWord: $searchWord, wordMatchFound: $wordMatchFound))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(wordMatchFound ? Color.green : Color.red, width: 2)
                .disableAutocorrection(true)
                
            HStack {
                Button(action: {
                    // Searches dictionary for the word (uppercased, since our dictionary is uppercased and trimming spaces)
                    if ( self.dictionaryManager.dictionary.contains(self.searchWord.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)) ) {
                        self.wordMatchFound = true
                    } else {
                        
                    }
                }) {
                    Text("Search")
                }
            }
            
            HStack {
                Text("Score Keeper")
                    .font(.callout)
                    .bold()
            }.padding(.top)
            
            HStack {
                VStack {
                    Text("Player One Score")
                    Text(String(playerOneScore))
                        .bold()
                    TextField("Enter score", value: $playerOneScoreIncrement, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(UIKeyboardType.decimalPad)
                    
                    HStack {
                        Button(action: {
                            // Add the entry from the text field to Player One's score
                            print(self.playerOneScoreIncrement)
                            self.playerOneScoreTracker.scores.append(self.playerOneScoreIncrement)
                            self.playerOneScore = self.playerOneScoreTracker.getScore()
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "minus.circle")
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Player Two Score")
                    Text(String(playerTwoScore))
                    .bold()
                    TextField("Enter score", value: $playerTwoScoreIncrement, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(UIKeyboardType.decimalPad)
                        
                        HStack {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "plus.circle")
                            }
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image(systemName: "minus.circle")
                            }
                        }
                }
            }
            
        }.padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
