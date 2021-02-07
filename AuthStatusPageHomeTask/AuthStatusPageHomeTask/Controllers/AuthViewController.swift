//
//  AuthViewController.swift
//  AuthStatusPageHomeTask
//
//  Created by Artur on 02.02.2021.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK: - Properties
    private var greetingMessage: String = NSLocalizedString("Greeting message", comment: "")
    private var defaultUserMessage: String = NSLocalizedString("Default user", comment: "")
    private var errorMessage: String = NSLocalizedString("Error", comment: "")
    private var registerButton: String = NSLocalizedString("Registration", comment: "")
    
    // MARK: - Outlets
    @IBOutlet weak var mainLabel: UILabel! {
        didSet {
            self.mainLabel.layer.cornerRadius = 15
            self.mainLabel.isHidden = true
            self.mainLabel.clipsToBounds = true
            self.mainLabel.numberOfLines = 0
            self.mainLabel.layer.borderWidth = 1
            self.mainLabel.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            self.userNameTextField.placeholder = NSLocalizedString("PlaceholderUsername",
                                                                   comment: "")
            self.userNameTextField.clearButtonMode = .whileEditing
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.placeholder = NSLocalizedString("PlaceholderPassword",
                                                                   comment: "")
            self.passwordTextField.clearButtonMode = .whileEditing
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var enterButton: UIButton! {
        didSet {
            self.enterButton.layer.cornerRadius = 20
            self.enterButton.layer.borderWidth = 1
            self.enterButton.layer.borderColor = UIColor.white.cgColor
            self.enterButton.layer.shadowRadius = 20
            self.enterButton.layer.shadowOpacity = 0.6
            self.enterButton.layer.shadowColor = UIColor.blue.cgColor
            self.enterButton.setTitle(self.registerButton, for: .normal)
        }
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.setAlert),
                                               name: .statusPersonAuthorized,
                                               object: nil)
    }
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveSecondViewController",
           let destinationVC = segue.destination as? StatusViewController {
            guard let username = self.userNameTextField.text,
                  let password = self.passwordTextField.text else { return }
            destinationVC.username = username
            destinationVC.setPassword(with: password)
            destinationVC.delegate = self
            
            destinationVC.closure = { [weak self] status in
                guard let self = self else { return }
                if let username = destinationVC.username {
                    self.mainLabel.isHidden = false
                    switch status.rawValue {
                    case 0:
                        self.mainLabel.backgroundColor = .systemBlue
                        if username == "" {
                            self.mainLabel.text = "\(self.greetingMessage)\(self.defaultUserMessage)"
                        } else {
                            self.mainLabel.text = "\(self.greetingMessage)\(username)"
                        }
                    case 1:
                        self.mainLabel.backgroundColor = .orange
                        self.mainLabel.text = self.errorMessage
                    default: break
                    }
                }
            }
        }
    }
    // MARK: - Methods
    @objc private func setAlert(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let status = userInfo["status"] as? StatusViewController.RegisterStatus else { return }
        AlertSingletone.shared.setAlert(for: self, with: status)
    }
}
