//
//  DictionaryManager.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 4/27/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import Foundation

class DictionaryManager {
    let dictionaryFileName = "dictionary.txt"
    
    var dictionary : Array<String> = [""]
    
    init() {
        self.dictionary = self.loadDictionary()!
    }
    
    func loadDictionary() -> Array<String>? {
        
        if let filepath = Bundle.main.path(forResource: "dictionary", ofType: "txt") {
            
            do {
                let contents = try String(contentsOfFile: filepath)
                let words : [String] = contents.components(separatedBy:NSCharacterSet.newlines)
                
                return words
            
            } catch {
                // contents could not be loaded
                print(error)
                return nil
            }
        } else {
            // example.txt not found!
            return ["Text file not found"]
        }
    
    }
    
}
