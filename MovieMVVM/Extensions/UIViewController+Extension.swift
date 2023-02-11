// UIViewController+Extension.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

/// Добавление Alert
extension UIViewController {
    // MARK: - Public Methods

    func showErrorAlert(alertTitle: String?, message: String?, actionTitle: String?) {
        let errorAlertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okErrorAlertControllerAction = UIAlertAction(title: actionTitle, style: .cancel)
        errorAlertController.addAction(okErrorAlertControllerAction)
        present(errorAlertController, animated: true)
    }

    func showAlert(title: String, message: String, actionTitle: String, completion: @escaping (String) -> Void) {
        let actionController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            guard let key = actionController.textFields?.first?.text else { return }
            completion(key)
        }
        actionController.addTextField(configurationHandler: nil)
        actionController.addAction(alertAction)
        present(actionController, animated: true, completion: nil)
    }
}
