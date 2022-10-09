//
//  BaseModalViewController.swift
//
//  Created by Eric Ziegler on 9/12/22.
//

import UIKit

class BaseModalViewController: BaseViewController {
 
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let closeImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))?.maskedWithColor(UIColor.tintColor)
        let closeButton = RegularButton(type: .custom)
        closeButton.addTarget(self, action: #selector(self.closeTapped(_:)), for: .touchUpInside)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let closeItem = UIBarButtonItem(customView: closeButton)
        self.navigationItem.leftBarButtonItem = closeItem
    }
    
    // MARK: - Helpers
    
    internal func showCloseWarning() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Unsaved Changes", message: "Are you sure you would like to close? Any changes made will be lost.", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default) { action in
                self.dismiss(animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(closeAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @objc func closeTapped(_ sender: AnyObject) {
        self.dismiss(animated: true)
    }
    
}
