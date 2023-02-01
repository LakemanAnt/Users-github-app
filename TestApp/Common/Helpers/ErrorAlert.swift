//
//  ErrorAlert.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class ErrorAlert {
    static func showErrorAlert(with message: String) {
        guard let viewController = UIApplication.topViewController() else {
            return
        }
        let alert = UIAlertController(title: "error_title".localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".localized, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
