//
//  InfoViewController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        let alertButton = UIButton()
        alertButton.backgroundColor = .purple
        alertButton.setTitle("Alert", for: .normal)
        alertButton.tintColor = .white
        alertButton.layer.cornerRadius = 15
        alertButton.addTarget(self, action: #selector(alertButtonAction(_:)), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        return alertButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        self.view.addSubview(self.alertButton)
        
        let alertButtonBottom = self.alertButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        let alertButtonLeading = self.alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let alertButtonTrailing = self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let alertButtonHeight = self.alertButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([alertButtonBottom, alertButtonHeight, alertButtonLeading, alertButtonTrailing])
    }
    
    @objc func alertButtonAction(_ sender:UIButton!) {
        let alertController = UIAlertController(title: "Важно", message: "Очень важно", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!)
            in print("Нажали кнопку ок");
        }
                alertController.addAction(OKAction)
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!)
            in print("Нажали кнопку отмены");
        }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
    }
}

