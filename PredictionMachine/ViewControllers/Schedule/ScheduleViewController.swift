//
//  ScheduleViewController.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/9/22.
//

import UIKit

class ScheduleViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
 
    // MARK: - Properties
    
    private static let storyboardName = "Schedule"
    private static let storyboardId = "ScheduleViewId"
    
    @IBOutlet var scheduleTable: UITableView!
    
    private var viewModel = ScheduleViewModel()
    
    // MARK: - Init
    
    static func createController() -> ScheduleViewController {
        let storyboard = UIStoryboard(name: ScheduleViewController.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ScheduleViewController.storyboardId) as! ScheduleViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        loadSchedule()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Schedule"
    }
    
    private func loadSchedule() {
        do {
            try viewModel.loadSchedule()
            scheduleTable.reloadData()
        } catch {
            showAlert(title: "Uh oh!", message: error.localizedDescription)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weekCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekCell.reuseId, for: indexPath) as! WeekCell
        if let week = viewModel.week(at: indexPath.row) {
            cell.layoutFor(weekNumber: week.number)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let week = viewModel.week(at: indexPath.row) else {
            return
        }
        
        let controller = GamesViewController.createController(week: week)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
