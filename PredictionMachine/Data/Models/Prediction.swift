//
//  Prediction.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

class Prediction: Codable {
    var winningTeam: Team?
    var losingTeam: Team?
    var confidence: Double?
    var homeCount: Int = 0
    var visitorCount: Int = 0
}
