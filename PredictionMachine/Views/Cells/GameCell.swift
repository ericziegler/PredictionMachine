//
//  GameCell.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import UIKit

class GameCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "GameCellId"
    
    @IBOutlet var visitorBackground: UIView!
    @IBOutlet var visitorButton: RegularButton!
    @IBOutlet var homeBackground: UIView!
    @IBOutlet var homeButton: RegularButton!
    @IBOutlet var predictionImageView: UIImageView!
    @IBOutlet var predictionLabel: MediumLabel!
    @IBOutlet var confidenceLabel: MediumLabel!
    
    var homeTapped: (() -> Void)?
    var visitorTapped: (() -> Void)?
    
    // MARK: - Layout
    
    func layout(for game: Game, prediction: Prediction?) {
        // visitor
        visitorBackground.backgroundColor = game.visitor.primaryColor.colorValue
        visitorButton.setImage(UIImage(named: game.visitor.image), for: .normal)
        
        // home
        homeBackground.backgroundColor = game.home.primaryColor.colorValue
        homeButton.setImage(UIImage(named: game.home.image), for: .normal)
        
        // prediction
        if let prediction = prediction {
            // team
            predictionImageView.image = UIImage(named: prediction.team.image)
            predictionLabel.text = "Prediction: \(prediction.team.name)"
            
            // percent confident
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.maximumFractionDigits = 0
            confidenceLabel.text = "Confidence: \(formatter.string(from: NSNumber(value: prediction.confidence)) ?? "--")"
        } else {
            predictionImageView.image = nil
            predictionLabel.text = "Prediction: --"
            confidenceLabel.text = "Confidence: --"
        }
    }
    
    // MARK: - Actions
    
    @IBAction func homeTapped(_ sender: AnyObject) {
        homeTapped?()
    }
    
    @IBAction func visitorTapped(_ sender: AnyObject) {
        visitorTapped?()
    }
    
}
