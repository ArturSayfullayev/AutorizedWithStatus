//
//  Singletone.swift
//  AuthStatusPageHomeTask
//
//  Created by Artur on 05.02.2021.
//

import UIKit

class AlertSingletone {
    // MARK: - Properties
    private var sucsesfulAlertMessage: String = NSLocalizedString("Succesful alert", comment: "")
    private var errorAlertMessage: String = NSLocalizedString("Error alert", comment: "")
    // MARK: - Singleton
    static let shared = AlertSingletone()
    
    // MARK: - Initialization
    private init() { }
    
    // MARK: - Methods
    func setAlert(for controller: UIViewController,
                  with status: StatusViewController.RegisterStatus) {
        switch status.rawValue {
        case 0:
            let alert = UIAlertController(title: self.sucsesfulAlertMessage,
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            controller.present(alert, animated: true)
        case 1:
            let alert = UIAlertController(title: self.errorAlertMessage,
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .destructive,
                                          handler: nil))
            controller.present(alert, animated: true)
        default:
            break
        }
    }
}

extension AlertSingletone: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
