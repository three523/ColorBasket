//
//  ImageCollectionViewCell.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let registerId = "\(ImageCollectionViewCell.self)"
    var mainView: UIView = UIView()
    var imageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var color: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        
        let titleLabelHeight:CGFloat = 30
        let widthPadding:CGFloat = 20
        
        let imageViewSize = UIScreen.main.bounds.width/2 - (widthPadding + titleLabelHeight)
        
        mainView.addSubview(imageView)
        mainView.addSubview(titleLabel)
        contentView.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 4).isActive = true
        imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 4).isActive = true
        imageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 4).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 4).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
