//
//  AuthViewController.swift
//  AuthStatusPageHomeTask
//
//  Created by Artur on 02.02.2021.
//

import UIKit

class AuthViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLabel()
        self.setUserNameTextField()
        self.setPasswordTextField()
        self.setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.setAlert),
                                               name: .statusPersonAuthorized,
                                               object: nil)
    }
    
    // MARK: - Actions
    @IBAction func moveToSecondVC(_ sender: Any) {
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveSecondViewController",
           let destinationVC = segue.destination as? StatusViewController {
            guard let username = self.userNameTextField.text,
                  let password = self.passwordTextField.text else { return }
            destinationVC.username = username
            destinationVC.setPasswrod(with: password)
            destinationVC.delegate = self
            
            destinationVC.closure = { [weak self] status in
                guard let self = self else { return }
                self.mainLabel.isHidden = false
                if status.rawValue == 0 {
                    self.mainLabel.backgroundColor = .systemBlue
                    self.mainLabel.text = "Добро пожаловать, \(destinationVC.username ?? "пользователь")!"
                } else if status.rawValue == 1 {
                    self.mainLabel.backgroundColor = .orange
                    self.mainLabel.text = "Ошибка"
                }
            }
        }
    }
    
    // MARK: - Methods
    
    private func setLabel() {
        self.mainLabel.layer.cornerRadius = 15
        self.mainLabel.isHidden = true
        self.mainLabel.clipsToBounds = true
        self.mainLabel.numberOfLines = 0
        self.mainLabel.layer.borderWidth = 1
        self.mainLabel.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setPasswordTextField() {
        self.passwordTextField.placeholder = "Введите ваш пароль"
        self.passwordTextField.clearButtonMode = .whileEditing
        self.passwordTextField.isSecureTextEntry = true
    }
    
    private func setUserNameTextField() {
        self.userNameTextField.placeholder = "Введите ваш логин"
        self.userNameTextField.clearButtonMode = .whileEditing
    }
    
    private func setButton() {
        self.enterButton.layer.cornerRadius = 20
        self.enterButton.layer.borderWidth = 1
        self.enterButton.layer.borderColor = UIColor.white.cgColor
        self.enterButton.layer.shadowRadius = 20
        self.enterButton.layer.shadowOpacity = 0.6
        self.enterButton.layer.shadowColor = UIColor.blue.cgColor
    }
    
    @objc private func setAlert(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let statusRowValue: Int = userInfo["status"] as? Int else  { return }
        if statusRowValue == 0 {
        let alert = UIAlertController(title: "Вы успешно зарегистрировались",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
            self.present(alert, animated: true)
        } else if statusRowValue == 1 {
        let alert = UIAlertController(title: "Регистрация не удалась",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .destructive,
                                      handler: nil))
            self.present(alert, animated: true)
        }
    }
}
