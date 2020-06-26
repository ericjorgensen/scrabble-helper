//
//  ScoreTracker.swift
//  Scrabble Helper
//
//  Created by Eric Jorgensen on 4/29/20.
//  Copyright © 2020 Eric Jorgensen. All rights reserved.
//

import Foundation

class ScoreTracker: ObservableObject {
    var scores : [Score] = []
    
    @Published var playerOneScores : [Score] = []
    @Published var playerTwoScores : [Score] = []
    
    func getPlayerOneScore() -> Double {
        return self.playerOneScores.reduce(0, { x, y in
            x + y.value
        })
    }
    
    func getPlayerTwoScore() -> Double {
        return self.playerTwoScores.reduce(0, { x, y in
            x + y.value
        })
    }
}
