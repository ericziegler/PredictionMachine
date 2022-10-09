//
//  Schedule.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

class Schedule: Codable {
    let weeks: [Week]
    
    init(weeks: [Week]) {
        self.weeks = weeks
    }
}
