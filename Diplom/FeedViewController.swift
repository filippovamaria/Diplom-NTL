//
//  FeedViewController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

class FeedViewController: UIViewController{
    
    private lazy var postButton: UIButton = {
        let postButton = UIButton()
        postButton.backgroundColor = .purple
        postButton.setTitle("Показать пост", for: .normal)
        postButton.tintColor = .white
        postButton.layer.cornerRadius = 15
        postButton.addTarget(self, action: #selector(postButtonAction(_:)), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        return postButton
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Feed"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(self.postButton)
        
        self.postButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    @objc func postButtonAction(_ sender: UIButton!) {
       let postViewController = PostViewController()
        let post = Post(title: "Новый Пост")
                postViewController.postTitle = post.title
       self.navigationController?.pushViewController(postViewController, animated: true)
    }
}

struct Post {
    var title: String?
}


