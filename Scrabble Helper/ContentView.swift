//
//  ContentView.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 4/27/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchWord: String = ""
    @State private var wordMatchFound: Bool = false
    
    let dictionaryManager = DictionaryManager()
    
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
                    if ( self.dictionaryManager.dictionary.contains(self.searchWord.uppercased()) ) {
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
