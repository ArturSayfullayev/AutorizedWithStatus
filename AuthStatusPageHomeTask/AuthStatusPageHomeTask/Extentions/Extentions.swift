//
//  Extentions.swift
//  AuthStatusPageHomeTask
//
//  Created by Artur on 02.02.2021.
//

import Foundation

extension AuthViewController: ChangeColorOfBackground {
    func changeColorOfBackground(with status: StatusViewController.RegisterStatus) {
        switch status.rawValue {
        case 0:
            self.view.backgroundColor = .green
        case 1:
            self.view.backgroundColor = .red
        default:
            break
        }
    }
}


extension Notification.Name {
    static let statusPersonAuthorized = Notification.Name("statusOfPersonUpdated")
}
