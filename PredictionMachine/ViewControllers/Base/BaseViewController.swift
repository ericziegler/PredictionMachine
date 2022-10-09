//
//  BaseViewController.swift
//
//  Created by Eric Ziegler
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties

    var baseNavController: BaseNavigationController? {
        guard let navController = self.navigationController as? BaseNavigationController else {
            return nil
        }
        return navController
    }

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        updateAppearance()
        registerForNotifications()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch Settings.shared.selectedInterfaceStyle {
        case .dark:
            return .lightContent
        case .light:
            return .darkContent
        default:
            return .default
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance()
    }

    // MARK: - Helpers

    @objc func updateAppearance() {
        self.setNeedsStatusBarAppearanceUpdate()
        switch Settings.shared.selectedInterfaceStyle {
        case .dark:
            self.overrideUserInterfaceStyle = .dark
        case .light:
            self.overrideUserInterfaceStyle = .light
        default:
            self.overrideUserInterfaceStyle = .unspecified
        }
        self.navigationController?.navigationBar.titleTextAttributes = navTitleTextAttributes(for: self.view.traitCollection)
    }

    func showAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Notifications
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateAppearance), name: Notification.Name.userInterfaceStyleChanged, object: nil)
    }

}
