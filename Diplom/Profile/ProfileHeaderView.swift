//
//  ProfileHeaderView.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private let defaults = UserDefaults.standard
    private var buttonTopConstraint: NSLayoutConstraint?
    private var tapRemoveKeyBoard = UITapGestureRecognizer()
    
    private lazy var userPhoto: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "imageCell1"))
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Beautiful Lady"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var userStatus: UITextField = {
        let textField = UITextField()
        textField.isHidden = false
        textField.placeholder = "Waiting for something..."
        textField.text = defaults.string(forKey: "Статус")
        textField.tintColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Set status", for: .normal)
        button.tintColor = .white
        
        button.layer.cornerRadius = 16
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        self.drawSelf()
        self.setUpGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.addSubview(self.statusButton)
        self.addSubview(labelsStackView)
        self.addSubview(userPhoto)
        
        self.labelsStackView.addArrangedSubview(self.userName)
        self.labelsStackView.addArrangedSubview(self.userStatus)
        
        let userPhotoTop = userPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let userPhotoLeft = userPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let userPhotoWidth = userPhoto.widthAnchor.constraint(equalToConstant: 120)
        let userPhotoHeight = userPhoto.heightAnchor.constraint(equalToConstant: 120)
        
        let labelsStackViewTop = labelsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let labelsStackViewLeft = labelsStackView.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 16)

        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.userPhoto.bottomAnchor, constant: 16)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            userPhotoTop, userPhotoLeft, userPhotoWidth, userPhotoHeight,
            labelsStackViewTop, labelsStackViewLeft,
            self.buttonTopConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint
        ].compactMap({ $0 }))
    }
    
    @objc private func setUpGesture() {
        tapRemoveKeyBoard.addTarget(self, action: #selector(removeKbTap(_:)))
        self.addGestureRecognizer(tapRemoveKeyBoard)
    }
    
    @objc private func didTapStatusButton() {
        if userStatus.text != nil {
            defaults.set(userStatus.text!, forKey: "Статус")
            UIView.animate(withDuration: 0.1) {
                self.statusButton.backgroundColor = .gray
            } completion: { _ in
                self.statusButton.backgroundColor = .blue
            }
        }
    }
    
    @objc private func removeKbTap(_ sender: Any) {
        userStatus.resignFirstResponder()
    }
    
}

