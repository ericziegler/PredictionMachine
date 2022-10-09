//
//  WeekCell.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import UIKit

class WeekCell: UITableViewCell {
 
    // MARK: - Properties
    
    static let reuseId = "WeekCellId"
    
    @IBOutlet var nameLabel: RegularLabel!
    
    // MARK: - Layout
    
    func layoutFor(weekNumber: Int) {
        nameLabel.text = "Week \(weekNumber)"
    }
    
}
