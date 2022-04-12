//
//  PhotosCollectionViewCellDelegate.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

protocol PhotosCollectionViewCellDelegate {
    func didTapImageCVCellDelegate()
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var imageCVCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageCVCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCVCell.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
}

