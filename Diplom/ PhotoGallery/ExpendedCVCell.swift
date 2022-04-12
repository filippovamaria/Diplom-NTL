//
//  ExpendedCVCell.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

protocol ExpendedCVCellDelegate: AnyObject {
    func didTapbuttonMultiply(view: ExpendedCVCell)
}

class ExpendedCVCell: UIView {
    
    weak var delegate: ExpendedCVCellDelegate?
    var tapButtonMultiply = UITapGestureRecognizer()
    
    lazy var imageExpendedCVCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
      lazy var buttonMultiply: UIImageView = {
         let buttonMultiply = UIImageView()
         buttonMultiply.image = UIImage(systemName: "multiply")
         buttonMultiply.tintColor = .white
         buttonMultiply.alpha = 0
         buttonMultiply.isUserInteractionEnabled = true
         buttonMultiply.translatesAutoresizingMaskIntoConstraints = false
         return buttonMultiply
     }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        drawSelf()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.addSubview(imageExpendedCVCell)
        self.addSubview(buttonMultiply)
        
        NSLayoutConstraint.activate([
            imageExpendedCVCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageExpendedCVCell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageExpendedCVCell.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageExpendedCVCell.heightAnchor.constraint(equalTo: self.widthAnchor),
            buttonMultiply.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            buttonMultiply.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonMultiply.widthAnchor.constraint(equalToConstant: 20),
            buttonMultiply.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func setUpGesture() {
        tapButtonMultiply.addTarget(self, action: #selector(didTapButtonMultiply(_:)))
        buttonMultiply.addGestureRecognizer(tapButtonMultiply)
    }
    
    @objc func didTapButtonMultiply(_ gestureRecognizer: UITapGestureRecognizer) {
        delegate?.didTapbuttonMultiply(view: self)
    }
}

