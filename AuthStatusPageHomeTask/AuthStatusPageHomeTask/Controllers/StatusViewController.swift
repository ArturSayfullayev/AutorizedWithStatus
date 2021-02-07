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
        
        func getBGColor() -> UIColor{
            return self.rawValue == 0 ? .green : .red
        }
    }
    // MARK: - Properties
    private var closeButtonTitle: String = NSLocalizedString("Close", comment: "")
    private var status: RegisterStatus?
    private var password: String?
    
    var username: String?
    
    weak var delegate: AuthViewController?
    
    // MARK: - Closure
    var closure: ((StatusViewController.RegisterStatus) -> ())?
    
    // MARK: - Outlets
    @IBOutlet weak var mainLabel: UILabel! {
        didSet {
            self.mainLabel.backgroundColor = .lightGray
            self.mainLabel.numberOfLines = 0
            self.mainLabel.layer.cornerRadius = 15
            self.mainLabel.clipsToBounds = true
            self.mainLabel.layer.borderColor = UIColor.black.cgColor
            self.mainLabel.layer.borderWidth = 1
            self.mainLabel.text = self.username
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            self.closeButton.layer.cornerRadius = 20
            self.closeButton.layer.borderWidth = 1
            self.closeButton.layer.borderColor = UIColor.white.cgColor
            self.closeButton.layer.shadowRadius = 20
            self.closeButton.layer.shadowOpacity = 0.6
            self.closeButton.layer.shadowColor = UIColor.cyan.cgColor
            self.closeButton.setTitle(self.closeButtonTitle, for: .normal)
        }
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setStatus()
    }
    
    // MARK: - Actions
    @IBAction func pressCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
        
        // Delegate
        self.delegate?.view.backgroundColor = self.status?.getBGColor()
        
        // Notification
        guard let status = self.status else { return }
        NotificationCenter.default.post(name: .statusPersonAuthorized,
                                        object: nil,
                                        userInfo: ["status": status])
        //Closure
        self.closure?(status)
    }
    // MARK:  - Methods
    private func setStatus() {
        guard let usernameCounter = self.username?.count,
              let passwordCounter = self.password?.count else { return }
        self.status = (usernameCounter + passwordCounter) > 14 ? .confirmed : .declined
    }
    
    func setPassword(with password: String) {
        self.password = password
    }
}
