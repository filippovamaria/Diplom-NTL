//
//  PhotosViewController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var photosCV: UICollectionView = {
        let photosCV = UICollectionView(frame: .zero,
                                        collectionViewLayout: layout)
        photosCV.backgroundColor = .white
        photosCV.delegate = self
        photosCV.dataSource = self
        photosCV.register(PhotosCollectionViewCell.self,
                          forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        photosCV.translatesAutoresizingMaskIntoConstraints = false
        return photosCV
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraint()
        
        title = "Photo Gallery"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setUpView() {
        view.addSubview(photosCV)
    }
    
    private func setUpConstraint() {
        let photosCVTop = photosCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let photosCVLeft = photosCV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        let photosCVRight = photosCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        let photosCVBottom = photosCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([photosCVTop, photosCVLeft, photosCVRight, photosCVBottom])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat, with itemPerRow: CGFloat) -> CGSize{
            let neededWidth = width - 2 * spacing
            let itemWidth = neededWidth / itemPerRow
            return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.imageCVCell.image = photosArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)!.minimumLineSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing, with: itemsPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let expendedCVCell = ExpendedCVCell()
        expendedCVCell.delegate = self
        self.view.addSubview(expendedCVCell)
        
        expendedCVCell.imageExpendedCVCell.image = photosArray[indexPath.row]
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        
        NSLayoutConstraint.activate([
            expendedCVCell.topAnchor.constraint(equalTo: self.view.topAnchor),
            expendedCVCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            expendedCVCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            expendedCVCell.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])

        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                expendedCVCell.buttonMultiply.alpha = 1
                expendedCVCell.backgroundColor = .black.withAlphaComponent(0.8)
            }
        }
    }
}

extension PhotosViewController: ExpendedCVCellDelegate {
    func didTapbuttonMultiply(view: ExpendedCVCell) {
        view.removeFromSuperview()
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
}

