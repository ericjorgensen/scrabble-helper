//
//  ScoreTracker.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 4/29/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import Foundation

class ScoreTracker: ObservableObject {
    
    @Published var scores : [Score] = []
    
    func getScore() -> Double {
        return self.scores.reduce(0, { x, y in
            x + y.value
        })
    }
}
