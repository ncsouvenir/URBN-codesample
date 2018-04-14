//
//  Alerts.swift
//  URBN-codesample
//
//  Created by C4Q on 4/13/18.
//

import UIKit

class Alerts {
    
    public static func presentSettingsAlertController(withTitle title: String?, andMessage message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        addAction(withTitle: "Cancel", style: .cancel, toAlertController: alertController, andCompletion: nil)
        addAction(withTitle: "Settings", style: .default, toAlertController: alertController) { (_) in
            guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {return}
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
    
    public static func createAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    
    public static func createActionSheet(withTitle title: String, andMessage message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    
    public static func addAction(withTitle title: String, style: UIAlertActionStyle, toAlertController alertController: UIAlertController, andCompletion completion: ((UIAlertAction) -> Void)?) {
        let alertAction = UIAlertAction(title: title, style: style, handler: completion)
        alertController.addAction(alertAction)
    }
    
    
    public static func createErrorAlert(withMessage message: String, andCompletion completion: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let errorAlert = createAlert(withTitle: "Error", andMessage: message)
        addAction(withTitle: "Sorry", style: .default, toAlertController: errorAlert, andCompletion: completion)
        return errorAlert
    }
    
    
    public static func createSuccessAlert(withMessage message: String, andCompletion completion: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let successAlert = createAlert(withTitle: "Success!", andMessage: message)
        addAction(withTitle: "Whoo", style: .default, toAlertController: successAlert, andCompletion: completion)
        return successAlert
    }
}

