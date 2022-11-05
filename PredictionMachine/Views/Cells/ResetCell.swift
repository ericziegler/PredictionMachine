//
//  ResetCell.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 11/4/22.
//

import UIKit

class ResetCell: UITableViewCell {
 
    // MARK: - Properties
    
    static let reuseId = "ResetCellId"
    
    var resetAllTapped: (() -> Void)?
    
    // MARK: - Actions
    
    @IBAction func resetAllTapped(_ sender: AnyObject) {
        resetAllTapped?()
    }
    
}
