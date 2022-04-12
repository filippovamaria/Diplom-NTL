//
//  ExtendedPost.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

protocol ExtendedPostDelegate: AnyObject {
    func didTapButtonMultiplyDelegate(view: ExtendedPost)
}

class ExtendedPost: UIView {
    
    weak var delegate: ExtendedPostDelegate?
    private var tapButtonMultiply = UITapGestureRecognizer()
    
    private lazy var authorNickname: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var postDiscription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.tintColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likesText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Likes:"
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likesCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var viewsText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Views:"
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var viewsCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     private lazy var viewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var buttonMultiply: UIImageView = {
        let buttonMultiply = UIImageView(image: UIImage(systemName: "multiply"))
        buttonMultiply.tintColor = .black
        buttonMultiply.isUserInteractionEnabled = true
        buttonMultiply.translatesAutoresizingMaskIntoConstraints = false
        return buttonMultiply
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        drawSelf()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.addSubview(buttonMultiply)
        self.addSubview(authorNickname)
        self.addSubview(postImage)
        self.addSubview(postDiscription)
        self.addSubview(likesStack)
        self.addSubview(viewsStack)
        likesStack.addArrangedSubview(likesText)
        likesStack.addArrangedSubview(likesCount)
        viewsStack.addArrangedSubview(viewsText)
        viewsStack.addArrangedSubview(viewsCount)
        
        let buttonMultiplyTop = buttonMultiply.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let buttonMultiplyRight = buttonMultiply.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let buttonMultiplyWidth = buttonMultiply.widthAnchor.constraint(equalToConstant: 20)
        let buttonMultiplyHeight = buttonMultiply.heightAnchor.constraint(equalToConstant: 25)

        let authorNicknameTop = authorNickname.topAnchor.constraint(equalTo: buttonMultiply.topAnchor, constant: 20)
        let authorNicknameXCentre = authorNickname.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        let postImageTop = postImage.topAnchor.constraint(equalTo: authorNickname.bottomAnchor, constant: 12)
        let postImageXCentre = postImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let postImageAspectRatio = postImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)

        let postDiscriptionTop = postDiscription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16)
        let postDiscriptionXCentre = postDiscription.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let postDiscriptionLeft = postDiscription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)

        let likesStackTop = likesStack.topAnchor.constraint(equalTo: postDiscription.bottomAnchor, constant: 16)
        let likesStackLeft = likesStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)

        let viewsStackTop = viewsStack.topAnchor.constraint(equalTo: postDiscription.bottomAnchor, constant: 16)
        let viewsStackRight = viewsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([buttonMultiplyTop, buttonMultiplyRight, buttonMultiplyWidth, buttonMultiplyHeight,
                                    authorNicknameTop, authorNicknameXCentre,
                                    postImageTop, postImageXCentre, postImageAspectRatio,
                                    postDiscriptionTop, postDiscriptionXCentre, postDiscriptionLeft,
                                    likesStackTop, likesStackLeft,
                                    viewsStackTop, viewsStackRight
                                    ])
        
    }
    
    private func setUpGesture() {
        tapButtonMultiply.addTarget(self, action: #selector(didTapButtonMultiply(_:)))
        buttonMultiply.addGestureRecognizer(tapButtonMultiply)
    }
    
    @objc func didTapButtonMultiply(_ gestureRecognizer: UITapGestureRecognizer) {
        guard tapButtonMultiply === gestureRecognizer else { return }
        delegate?.didTapButtonMultiplyDelegate(view: self)
    }
}

extension ExtendedPost {
    func setUpCell(with viewModel: PostProfile?) {
        guard let viewModel = viewModel else { return }
        
        self.authorNickname.text = viewModel.author
        self.postImage.image = UIImage(named: viewModel.image)
        self.postDiscription.text = viewModel.discription
        self.likesCount.text = String(viewModel.likes)
        self.viewsCount.text = String(viewModel.views)
    }
}

