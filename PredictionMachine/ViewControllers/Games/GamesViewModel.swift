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
    private var predictions = [String : Prediction]()
    
    // MARK: - Init
    
    init(week: Week? = nil) {
        self.week = week
        loadPredictions()
    }
    
    // MARK: - Loading / Saving
    
    private func loadPredictions() {
        guard let week = week else {
            return
        }
        
        for curGame in week.games {
            // cacheKey is [weekNumber]-[visiting]-[home]
            let cacheKey = "\(week.number)-\(curGame.predictionKey)"
            let prediction = loadCachedPrediction(key: cacheKey)
            predictions[curGame.predictionKey] = prediction
        }
    }
    
    private func loadCachedPrediction(key: String) -> Prediction {
        let defaults = UserDefaults.standard
        if let predictionData = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedPrediction = try? decoder.decode(Prediction.self, from: predictionData) {
                return loadedPrediction
            }
        }
        return Prediction()
    }
    
    private func savePredictions() {
        guard let week = week else {
            return
        }
        
        for curGame in week.games {
            if let prediction = predictions[curGame.predictionKey] {
                // cacheKey is [weekNumber]-[visiting]-[home]
                let cacheKey = "\(week.number)-\(curGame.predictionKey)"
                saveCachedPrediction(prediction, forKey: cacheKey)
            }
        }
    }
    
    private func saveCachedPrediction(_ prediction: Prediction, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(prediction) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
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
        guard let game = game(at: index), let prediction = prediction(for: game) else {
            return nil
        }
        
        return prediction
    }
    
    private func prediction(for game: Game) -> Prediction? {
        let prediction = predictions[game.predictionKey]
        return prediction
    }
    
    private func updatePrediction(_ prediction: Prediction, game: Game) {
        var winningTeam: Team?
        var losingTeam: Team?
        var countDiff: Int?
        var confidence: Double?
        
        if prediction.visitorCount > prediction.homeCount {
            // visitor should win
            winningTeam = game.visitor
            losingTeam = game.home
            countDiff = prediction.visitorCount - prediction.homeCount
        }
        else if prediction.homeCount > prediction.visitorCount {
            // home should win
            winningTeam = game.home
            losingTeam = game.visitor
            countDiff = prediction.homeCount - prediction.visitorCount
        }
        
        // calculate the percent confident
        let totalCount = prediction.visitorCount + prediction.homeCount
        if let countDiff = countDiff, totalCount > 0 {
            confidence = Double(countDiff) / Double(totalCount)
        }
        
        prediction.winningTeam = winningTeam
        prediction.losingTeam = losingTeam
        prediction.confidence = confidence
        
        savePredictions()
    }
    
    func gameName(at index: Int) -> String? {
        guard let week = self.week, index < week.games.count else {
            return nil
        }
        
        let game = week.games[index]
        return "\(game.visitor.location) at \(game.home.location)"
    }
    
    // MARK: - Update Picks
    
    func addPicks(for game: Game, isVisitor: Bool, count: Int) {
        guard let prediction = prediction(for: game) else {
            return
        }
        
        if isVisitor {
            prediction.visitorCount += count
        } else {
            prediction.homeCount += count
        }
        
        updatePrediction(prediction, game: game)
    }
    
    func removePicks(for game: Game, isVisitor: Bool, count: Int) {
        guard let prediction = prediction(for: game) else {
            return
        }
        
        if isVisitor {
            prediction.visitorCount -= count
            if prediction.visitorCount < 0 {
                prediction.visitorCount = 0
            }
        } else {
            prediction.homeCount -= count
            if prediction.homeCount < 0 {
                prediction.homeCount = 0
            }
        }
        
        updatePrediction(prediction, game: game)
    }
    
    func resetAllGames() {
        for (_, curPrediction) in predictions {
            curPrediction.visitorCount = 0
            curPrediction.homeCount = 0
        }
    }
    
}
