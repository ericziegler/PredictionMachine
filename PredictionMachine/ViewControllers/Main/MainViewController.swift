//
//  MainViewController.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/8/22.
//

import UIKit

class MainViewController: BaseViewController {

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentSchedule()
    }
    
    private func presentSchedule() {
        let controller = ScheduleViewController.createController()
        let navController = BaseNavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false)
    }

}

