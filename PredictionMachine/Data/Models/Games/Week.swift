//
//  Week.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

class Week: Codable {
    let number: Int
    let games: [Game]
    
    init(number: Int, games: [Game]) {
        self.number = number
        self.games = games
    }
}
