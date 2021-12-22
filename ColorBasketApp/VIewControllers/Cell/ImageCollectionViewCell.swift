//
//  ImageCollectionViewCell.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
   
    static let registerId = "\(ImageCollectionViewCell.self)"
    var mainView: UIView = UIView()
    var imageView: UIImageView = {
        let ig = UIImageView()
        ig.layer.cornerRadius = 10
        ig.clipsToBounds = true
        return ig
    }()
    var titleLabel: UILabel = UILabel()
    var color: String = ""
    let imageLoader = ImageLoader()
    var cellInfo: JsonData?
    var finishReload: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
                
        contentView.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
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
        imageView.heightAnchor.constraint(equalTo: mainView.heightAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 4).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    func setImage(_ cellInfo: JsonData) {
        
        self.cellInfo = cellInfo
        imageView.image = nil
        titleLabel.text = cellInfo.title
        
        imageLoader.loadImage(url: cellInfo.url) { image in
            self.imageView.image = image
        }
    }
    
    func snapShotForTransition() -> UIView! {
        let snapShotView = UIImageView()
        snapShotView.image = imageView.image
        snapShotView.frame = imageView.frame
        return snapShotView
    }
    
}
