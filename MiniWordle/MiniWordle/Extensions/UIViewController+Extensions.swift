//
//  UIAlertController+Extensions.swift
//  MiniWordle
//
//  Created by TranQuocBao on 25/06/2022.
//

import UIKit

extension UIViewController {
    func clearBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAlert(_ viewController: UIViewController?,
                   title: String,
                   message: String) {
        let dialogMessage = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
        DispatchQueue.main.async {
            viewController?.present(dialogMessage, animated: true)
        }
    }
    
    func showAlert(_ viewController: UIViewController?,
                   title: String,
                   message: String,
                   actions: [UIAlertAction]) {
        if actions.isEmpty {
            return
        }

        let dialogMessage = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)

        for action in actions {
            dialogMessage.addAction(action)
        }

        DispatchQueue.main.async {
            viewController?.present(dialogMessage, animated: true)
        }
    }

    func presentWithTopViewController(_ viewController: UIViewController?,
                                      animated: Bool = true,
                                      completion: (() -> ())? = nil) {
        guard let viewController = viewController else {
            return
        }

        UIApplication.topViewControllerInNavigationStack()?.present(viewController,
                                                                    animated: animated,
                                                                    completion: completion)
    }
}
