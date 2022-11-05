//
//  GamesViewController.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import UIKit

class GamesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
 
    // MARK: - Properties
    
    private static let storyboardName = "Games"
    private static let storyboardId = "GamesViewId"
    
    @IBOutlet var gamesTable: UITableView!
    
    private var viewModel = GamesViewModel()
    
    // MARK: - Init
    
    static func createController(week: Week) -> GamesViewController {
        let storyboard = UIStoryboard(name: GamesViewController.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: GamesViewController.storyboardId) as! GamesViewController
        controller.viewModel = GamesViewModel(week: week)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTable()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = viewModel.formattedWeekNumber
        
        let sortImage = UIImage(systemName: "arrow.up.arrow.down", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))?.maskedWithColor(UIColor.white)
        let sortButton = RegularButton(type: .custom)
        sortButton.addTarget(self, action: #selector(self.sortGamesTapped(_:)), for: .touchUpInside)
        sortButton.setImage(sortImage, for: .normal)
        sortButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let sortItem = UIBarButtonItem(customView: sortButton)
        self.navigationItem.rightBarButtonItem = sortItem
    }
    
    private func setupTable() {
        gamesTable.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
    }
    
    // MARK: - Actions
    
    @objc func sortGamesTapped(_ sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Sort Games", message: nil, preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Default", style: .default) { action in
            self.viewModel.curSort = .defaultSort
            self.viewModel.sortGames()
            DispatchQueue.main.async {
                self.gamesTable.reloadData()
            }
        }
        actionSheet.addAction(defaultAction)
        let confidenceAction = UIAlertAction(title: "Highest Confidence", style: .default) { action in
            self.viewModel.curSort = .highestConfidence
            self.viewModel.sortGames()
            DispatchQueue.main.async {
                self.gamesTable.reloadData()
            }
        }
        actionSheet.addAction(confidenceAction)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.gameCount + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < viewModel.gameCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.reuseId, for: indexPath) as! GameCell
            if let game = viewModel.game(at: indexPath.section) {
                let prediction = viewModel.prediction(for: indexPath.section)
                cell.layout(for: game, prediction: prediction)
                cell.homeTapped = {
                    self.showInputForGame(game, isVisitor: false, index: indexPath.section, isAdding: true)
                }
                cell.visitorTapped = {
                    self.showInputForGame(game, isVisitor: true, index: indexPath.section, isAdding: true)
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ResetCell.reuseId, for: indexPath) as! ResetCell
            cell.resetAllTapped = {
                self.promptResetAllGames()
            }
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.gameName(at: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let game = viewModel.game(at: indexPath.section), let prediction = viewModel.prediction(for: indexPath.section) else {
            return
        }
        
        showAlert(title: "Game Details", message: "\(game.visitor.name): \(prediction.visitorCount)\n\(game.home.name): \(prediction.homeCount)")
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section >= viewModel.gameCount {
            return nil
        }
        
        let removeAction = UIContextualAction(style: .normal, title: "Remove Picks") { (action, view, completion) in
            if let game = self.viewModel.game(at: indexPath.section) {
                self.showInputForGame(game, isVisitor: true, index: indexPath.section, isAdding: false)
                playHaptic()
            }
            completion(false)
        }
        removeAction.image = UIImage(systemName: "minus.circle")
        removeAction.backgroundColor =  UIColor.systemRed
     
        let config = UISwipeActionsConfiguration(actions: [removeAction])
        config.performsFirstActionWithFullSwipe = true
     
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section >= viewModel.gameCount {
            return nil
        }
        
        let removeAction = UIContextualAction(style: .normal, title: "Remove Picks") { (action, view, completion) in
            if let game = self.viewModel.game(at: indexPath.section) {
                self.showInputForGame(game, isVisitor: true, index: indexPath.section, isAdding: false)
                playHaptic()
            }
            completion(false)
        }
        removeAction.image = UIImage(systemName: "minus.circle")
        removeAction.backgroundColor =  UIColor.systemRed
     
        let config = UISwipeActionsConfiguration(actions: [removeAction])
        config.performsFirstActionWithFullSwipe = true
     
        return config
    }
    
    // MARK: - Helpers
    
    private func showInputForGame(_ game: Game, isVisitor: Bool, index: Int, isAdding: Bool) {
        DispatchQueue.main.async {
            let title = isAdding ? "Add Picks" : "Remove Picks"
            let controller = NumberInputViewController.createController(with: nil, placeholder: "Number of picks", isCurrency: false, isDecimal: false, title: title)
            controller.inputSavedBlock = { pickCount in
                if isAdding {
                    self.viewModel.addPicks(for: game, isVisitor: isVisitor, count: pickCount?.intValue ?? 0)
                } else {
                    self.viewModel.removePicks(for: game, isVisitor: isVisitor, count: pickCount?.intValue ?? 0)
                }
                self.gamesTable.reloadRows(at: [IndexPath(row: 0, section: index)], with: .none)
            }
            let navController = BaseNavigationController(rootViewController: controller)
            self.present(navController, animated: true)
        }
    }
    
    private func promptResetAllGames() {
        let alert = UIAlertController(title: "Reset All Games", message: "Are you sure you want to reset all game pick counts?", preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { action in
            self.resetAllGames()
        }
        alert.addAction(resetAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    private func resetAllGames() {
        viewModel.resetAllGames()
        DispatchQueue.main.async {
            self.gamesTable.reloadData()
        }
    }
    
}
