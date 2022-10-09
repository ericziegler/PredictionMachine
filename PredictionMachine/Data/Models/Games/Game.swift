//
//  Game.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

class Game: Codable {
    let home: Team
    let visitor: Team
    var predictionKey: String {
        "\(visitor.rawValue)-\(home.rawValue)"
    }
    
    init(home: Team, visitor: Team) {
        self.home = home
        self.visitor = visitor
    }
}
