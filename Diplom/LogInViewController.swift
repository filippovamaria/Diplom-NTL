//
//  LogInViewController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    var keybordDismissTapGesture: UIGestureRecognizer?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logo: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userFormView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 7
        textField.placeholder = "Email of phone"
        textField.textColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextBorder: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 7
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextBorder: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordAlertLabel: UILabel = {
        let passwordAlertLabel = UILabel()
        passwordAlertLabel.textColor = .systemRed
        passwordAlertLabel.text = "Пароль должен содержать минимум 8 знаков"
        passwordAlertLabel.alpha = 0
        passwordAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        return passwordAlertLabel
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.didTapLogInButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var tapRemoveKeyBoard = UITapGestureRecognizer()
    private var logInButtonTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.configureSubviews()
        self.setupConstraints()
        self.setUpGesture()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logo)
        self.scrollView.addSubview(self.userFormView)
        self.scrollView.addSubview(self.logInButton)
        self.scrollView.addSubview(self.passwordAlertLabel)
        userFormView.addArrangedSubview(emailTextBorder)
        userFormView.addArrangedSubview(passwordTextBorder)
        emailTextBorder.addSubview(emailTextField)
        passwordTextBorder.addSubview(passwordTextField)
        }
    
    private func setupConstraints() {
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        
        let logoXPosition = logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let logoTopConstraint = logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120)
        let logoWidth = logo.widthAnchor.constraint(equalToConstant: 100)
        let logoHeight = logo.heightAnchor.constraint(equalToConstant: 100)
        
        let userFormViewXPosition = userFormView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let userFormViewTopConstraint = userFormView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120)
        let userFormViewTrailingConstant = userFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        let userFormViewHeight = userFormView.heightAnchor.constraint(equalToConstant: 100)
        
        let emailTextFieldTop = emailTextField.topAnchor.constraint(equalTo: emailTextBorder.topAnchor)
        let emailTextFieldBottom = emailTextField.bottomAnchor.constraint(equalTo: emailTextBorder.bottomAnchor)
        let emailTextFieldRight = emailTextField.trailingAnchor.constraint(equalTo: emailTextBorder.trailingAnchor, constant: -5)
        let emailTextFieldLeft = emailTextField.leadingAnchor.constraint(equalTo: emailTextBorder.leadingAnchor, constant: 5)
        
        let passwordTextFieldTop = passwordTextField.topAnchor.constraint(equalTo: passwordTextBorder.topAnchor)
        let passwordTextFielddBottom = passwordTextField.bottomAnchor.constraint(equalTo: passwordTextBorder.bottomAnchor)
        let passwordTextFieldRight = passwordTextField.trailingAnchor.constraint(equalTo: passwordTextBorder.trailingAnchor, constant: -5)
        let passwordTextFieldLeft = passwordTextField.leadingAnchor.constraint(equalTo: passwordTextBorder.leadingAnchor, constant: 5)
       
        let logInButtonXPosition = logInButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        self.logInButtonTopConstraint = logInButton.topAnchor.constraint(equalTo: userFormView.bottomAnchor, constant: 16)
        let logInButtonTrailingConstraint = logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        let logInButtonHeight = logInButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            scrollViewTopConstraint, scrollViewRightConstraint, scrollViewBottomConstraint, scrollViewLeftConstraint,
            logoXPosition, logoTopConstraint, logoWidth, logoHeight,
            userFormViewXPosition, userFormViewTopConstraint, userFormViewTrailingConstant, userFormViewHeight,
            emailTextFieldTop, emailTextFieldLeft, emailTextFieldRight, emailTextFieldBottom,
            passwordTextFieldTop, passwordTextFieldLeft, passwordTextFieldRight, passwordTextFielddBottom,
            logInButtonXPosition, logInButtonTopConstraint, logInButtonTrailingConstraint, logInButtonHeight
        ].compactMap({ $0 }))
        
    }
    
    private func setUpGesture() {
        tapRemoveKeyBoard.addTarget(self, action: #selector(removeKbTap(_:)))
        scrollView.addGestureRecognizer(tapRemoveKeyBoard)
    }
    
    private func dataValidation() {
        let isValidEmailAddress = isValidEmailAddress(emailAddressString: emailTextField.text!)
        
        if isValidEmailAddress {
            if emailTextField.text == userData[0] && passwordTextField.text == userData[1] {
                let profileViewController = ProfileViewController()
                self.navigationController?.pushViewController(profileViewController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Ошибка", message: "Почта не прошла валидацию", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
       var returnValue = true
       let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
       
       do {
           let regex = try NSRegularExpression(pattern: emailRegEx)
           let nsString = emailAddressString as NSString
           let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
           
           if results.count == 0
           {
               returnValue = false
           }
           
       } catch let error as NSError {
           print("invalid regex: \(error.localizedDescription)")
           returnValue = false
       }
       
       return  returnValue
   }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardSize.height / 4)
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: keyboardSize.height, left: 0, bottom: 0, right: 0)
        }
    }

    @objc private func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
        scrollView.verticalScrollIndicatorInsets = .zero
        }
    
    @objc private func didTapLogInButton(){
        
        guard let emailTextFieldText = emailTextField.text else { return }
        guard let passwordTextFieldText = passwordTextField.text else { return }

        if emailTextFieldText.isEmpty {
            UIView.animate(withDuration: 1) { [self] in
                self.emailTextBorder.backgroundColor = .systemRed
                self.emailTextField.backgroundColor = .systemRed
            } completion: { _ in
                self.emailTextBorder.backgroundColor = .systemGray6
                self.emailTextField.backgroundColor = .systemGray6
            }
        } else {
            if passwordTextFieldText.isEmpty {
                UIView.animate(withDuration: 1) { [self] in
                    self.passwordTextField.backgroundColor = .systemRed
                    self.passwordTextBorder.backgroundColor = .systemRed
                } completion: { _ in
                    self.passwordTextField.backgroundColor = .systemGray6
                    self.passwordTextBorder.backgroundColor = .systemGray6
                }
            } else {
                if passwordTextFieldText.count >= 8 {
                    dataValidation()
                } else {
                        self.passwordAlertLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
                        self.passwordAlertLabel.topAnchor.constraint(equalTo: self.userFormView.bottomAnchor, constant: 16).isActive = true
                        self.logInButtonTopConstraint?.constant = 50
                        self.passwordAlertLabel.alpha = 1
                }
            }
        }
    }

    @objc private func removeKbTap(_ sender: Any) {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextBorder.resignFirstResponder()
        emailTextBorder.resignFirstResponder()
    }
}
