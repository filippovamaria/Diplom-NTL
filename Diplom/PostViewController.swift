//
//  PostViewController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    var postTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        title = postTitle ?? "Нет названия"
   
        let barButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(barButtonAction))
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func barButtonAction(_ sender: UIBarButtonItem!) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
}
