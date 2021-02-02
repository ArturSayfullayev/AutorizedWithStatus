//
//  StatusViewController.swift
//  AuthStatusPageHomeTask
//
//  Created by Artur on 02.02.2021.
//

import UIKit

class StatusViewController: UIViewController {
    // MARK: - Enums
    enum RegisterStatus: Int {
        case confirmed = 0
        case declined = 1
    }
    
    // MARK: - Properties
    private var status: RegisterStatus?
    private var password: String?
    
    var username: String?
    
    weak var delegate: ChangeColorOfBackground?
    
    // MARK: - Closure
    var closure: ((StatusViewController.RegisterStatus) -> ())?
    
    // MARK: - Outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatus()
        self.setCloseButton()
        self.setLabel()
        
    }
    
    // MARK: - Actions
    @IBAction func pressCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
        
        // Delegate
        guard let status = self.status else { return }
        self.delegate?.changeColorOfBackground(with: status)
        // Notification
        NotificationCenter.default.post(name: .statusPersonAuthorized,
                                        object: nil,
                                        userInfo: ["status": status.rawValue])
        //Closure
        self.closure?(status)
    }
    
    // MARK:  - Methods
    private func setStatus() {
        guard let username = self.username,
              let password = self.password else { return }
        if (username.count + password.count) > 14 {
            self.status = .confirmed
        } else {
            self.status = .declined
        }
        
    }
    
    private func setCloseButton() {
        self.closeButton.layer.cornerRadius = 20
        self.closeButton.layer.borderWidth = 1
        self.closeButton.layer.borderColor = UIColor.white.cgColor
        self.closeButton.layer.shadowRadius = 20
        self.closeButton.layer.shadowOpacity = 0.6
        self.closeButton.layer.shadowColor = UIColor.cyan.cgColor
    }
    
    private func setLabel() {
        self.mainLabel.backgroundColor = .lightGray
        self.mainLabel.numberOfLines = 0
        self.mainLabel.layer.cornerRadius = 15
        self.mainLabel.clipsToBounds = true
        self.mainLabel.layer.borderColor = UIColor.black.cgColor
        self.mainLabel.layer.borderWidth = 1
        self.mainLabel.text = self.username
    }
    
    func setPasswrod(with password: String) {
        self.password = password
    }
    
}
