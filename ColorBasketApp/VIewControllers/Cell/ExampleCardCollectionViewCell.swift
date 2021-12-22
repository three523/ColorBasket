//
//  ExampleCardCollectionViewCell.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/02.
//

import UIKit

enum ExampleCardMode: Int {
    case basket = 0
    case picture
    case wiseSaying
    case photoframe
    case text
    case profile
}
class ExampleCardCollectionViewCell: UICollectionViewCell {
    
    static let registerID: String = "\(ExampleCardCollectionViewCell.self)"
    
    public func settings(mode: ExampleCardMode) {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        
        switch mode {
        case .basket:
            
            let basketView = ExampleCardBasketCardView()
            contentView.addSubview(basketView)
            basketView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            basketView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            basketView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            basketView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            basketView.createSubviews()
            
            
        case .picture:
            
            let pictureView = ExampleCardPictureView()
            contentView.addSubview(pictureView)
            pictureView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            pictureView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            pictureView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            pictureView.createSubviews()
            
            
        case .wiseSaying:
            
            let wiseSayingView = ExampleCardWiseSayingView()
            contentView.addSubview(wiseSayingView)
            wiseSayingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            wiseSayingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            wiseSayingView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            wiseSayingView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            wiseSayingView.createSubviews()
            
            
        case .photoframe:
            let photoFrameView = ExampleCardPhotoFrameView()
            contentView.addSubview(photoFrameView)
            photoFrameView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            photoFrameView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            photoFrameView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            photoFrameView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            photoFrameView.createSubviews()
            
        case .text:
            let textView = ExampleCardTextView()
            contentView.addSubview(textView)
            textView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            textView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            textView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            textView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            textView.createSubviews()
            
        case .profile:
            let profileView = ExampleCardProfileView()
            contentView.addSubview(profileView)
            profileView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            profileView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            profileView.createSubviews()

        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.sublayers?.removeAll()
    }
}
