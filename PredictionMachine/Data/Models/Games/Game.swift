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
    var homeCount: Int = 0
    var visitorCount: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case home, visitor
    }
    
    init(home: Team, visitor: Team) {
        self.home = home
        self.visitor = visitor
    }
}
