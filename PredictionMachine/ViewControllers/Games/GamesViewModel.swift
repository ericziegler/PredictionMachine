//
//  GamesViewModel.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import Foundation

class GamesViewModel {
 
    // MARK: - Properties
    
    private let week: Week?
    
    // MARK: - Init
    
    init(week: Week? = nil) {
        self.week = week
    }
    
    // MARK: - Accessors
    
    var formattedWeekNumber: String {
        guard let week = self.week else {
            return ""
        }
        
        return "Week \(week.number)"
    }
    
    var gameCount: Int {
        guard let week = self.week else {
            return 0
        }
        
        return week.games.count
    }
    
    func game(at index: Int) -> Game? {
        guard let week = self.week, index < week.games.count else {
            return nil
        }
        
        return week.games[index]
    }
    
    func prediction(for index: Int) -> Prediction? {
        guard let game = game(at: index) else {
            return nil
        }
        
        var winningTeam: Team?
        var countDiff: Int?
        var confidence: Double?
        
        if game.visitorCount > game.homeCount {
            // visitor should win
            winningTeam = game.visitor
            countDiff = game.visitorCount - game.homeCount
        }
        else if game.homeCount > game.visitorCount {
            // home should win
            winningTeam = game.home
            countDiff = game.homeCount - game.visitorCount
        }
        
        // calculate the percent confident
        
        let totalCount = game.visitorCount + game.homeCount
        if let countDiff = countDiff, totalCount > 0 {
            confidence = Double(countDiff) / Double(totalCount)
        }
        
        if let winningTeam = winningTeam, let confidence = confidence {
            let prediction = Prediction(team: winningTeam, confidence: confidence)
            return prediction
        }
        
        return nil
    }
    
    func gameName(at index: Int) -> String? {
        guard let week = self.week, index < week.games.count else {
            return nil
        }
        
        let game = week.games[index]
        return "\(game.visitor.location) at \(game.home.location)"
    }
    
    func addPicks(for game: Game, isVisitor: Bool, count: Int) {
        if isVisitor {
            game.visitorCount += count
        } else {
            game.homeCount += count
        }
    }
    
    func removePicks(for game: Game, isVisitor: Bool, count: Int) {
        if isVisitor {
            game.visitorCount -= count
            if game.visitorCount < 0 {
                game.visitorCount = 0
            }
        } else {
            game.homeCount -= count
            if game.homeCount < 0 {
                game.homeCount = 0
            }
        }
    }
    
    // MARK: - Reset
    
    func resetAllGames() {
        guard let week = self.week else {
            return
        }
        
        for curGame in week.games {
            curGame.visitorCount = 0
            curGame.homeCount = 0
        }
    }
    
}
