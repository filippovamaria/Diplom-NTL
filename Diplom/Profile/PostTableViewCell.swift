//
//  PostTableViewCell.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func didTapLikesLabelDelegate(cell: PostTableViewCell)
    func didTapPostImageDelegate(cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    private var tapLike = UITapGestureRecognizer()
    private var tapPostImage = UITapGestureRecognizer()
    weak var delegate: PostTableViewCellDelegate?
    
    lazy var authorNickname: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var postDiscription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.tintColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var likesText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Likes:"
        label.tintColor = .black
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likesCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.tintColor = .black
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
      lazy var likesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.isUserInteractionEnabled = true
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
    
    lazy var viewsCount: UILabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorNickname.text = nil
        self.postImage.image = nil
        self.postDiscription.text = nil
        self.likesCount.text = nil
        self.viewsCount.text = nil
    }
    
    private func setUp() {
        self.contentView.addSubview(self.authorNickname)
        self.contentView.addSubview(self.postImage)
        self.contentView.addSubview(self.postDiscription)
        self.contentView.addSubview(self.likesStack)
        self.contentView.addSubview(self.viewsStack)
        self.likesStack.addArrangedSubview(self.likesText)
        self.likesStack.addArrangedSubview(self.likesCount)
        self.viewsStack.addArrangedSubview(self.viewsText)
        self.viewsStack.addArrangedSubview(self.viewsCount)
        
        let authorNicknameTop = authorNickname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        let authorNicknameLeft = authorNickname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        
        let postImageTop = postImage.topAnchor.constraint(equalTo: authorNickname.bottomAnchor, constant: 12)
        let postImageXCentre = postImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let postImageAspectRatio = postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1)

        let postDiscriptionTop = postDiscription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16)
        let postDiscriptionXCentre = postDiscription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let postDiscriptionLeft = postDiscription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)

        let likesStackTop = likesStack.topAnchor.constraint(equalTo: postDiscription.bottomAnchor, constant: 16)
        let likesStackLeft = likesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let likesStackBottom = likesStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)

        let viewsStackTop = viewsStack.topAnchor.constraint(equalTo: postDiscription.bottomAnchor, constant: 16)
        let viewsStackRight = viewsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        let viewsStackBottom = viewsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([authorNicknameTop, authorNicknameLeft,
                                    postImageTop, postImageXCentre, postImageAspectRatio,
                                    postDiscriptionTop, postDiscriptionXCentre, postDiscriptionLeft,
                                    likesStackTop, likesStackLeft, likesStackBottom,
                                    viewsStackTop, viewsStackRight, viewsStackBottom
                                    ])
    }
    
    private func setUpGesture() {
        tapLike.addTarget(self, action: #selector(didtapLikesLabel))
        likesStack.addGestureRecognizer(tapLike)
        
        tapPostImage.addTarget(self, action: #selector(didtapPostImage(_:)))
        postImage.addGestureRecognizer(tapPostImage)
    }
    
    @objc func didtapLikesLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapLike === gestureRecognizer else { return }
        delegate?.didTapLikesLabelDelegate(cell: self)
    }
    
    @objc func didtapPostImage(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapPostImage === gestureRecognizer else { return }
        delegate?.didTapPostImageDelegate(cell: self)
    }
    
}

extension PostTableViewCell {
    func setUpCell(with viewModel: PostProfile?) {
        guard let viewModel = viewModel else { return }
        
        self.authorNickname.text = viewModel.author
        self.postImage.image = UIImage(named: viewModel.image)
        self.postDiscription.text = viewModel.discription
        self.likesCount.text = String(viewModel.likes)
        self.viewsCount.text = String(viewModel.views)
    }
}

