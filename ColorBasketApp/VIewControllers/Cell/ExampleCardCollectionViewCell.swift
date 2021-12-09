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
//    let cardView = ExampleCardView()
    
    public func settings(mode: ExampleCardMode) {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        
//        cardViewSetting()
        
        switch mode {
        case .basket:
            
            let basketView = ExampleCardBasketCardView()
//            cardView.addSubview(basketView)
//            basketView.translatesAutoresizingMaskIntoConstraints = false
//            basketView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
//            basketView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//            basketView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
//            basketView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            contentView.addSubview(basketView)
            basketView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            basketView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            basketView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            basketView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            basketView.createSubviews()
            
//            animation(cardView: basketView)
            
        case .picture:
            
            let pictureView = ExampleCardPictureView()
//            cardView.addSubview(pictureView)
//            pictureView.translatesAutoresizingMaskIntoConstraints = false
//            pictureView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
//            pictureView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//            pictureView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
//            pictureView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            contentView.addSubview(pictureView)
            pictureView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            pictureView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            pictureView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            pictureView.createSubviews()
            
//            animation(cardView: pictureView)
            
        case .wiseSaying:
            
            let wiseSayingView = ExampleCardWiseSayingView()
//            cardView.addSubview(wiseSayingView)
//            wiseSayingView.translatesAutoresizingMaskIntoConstraints = false
//            wiseSayingView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
//            wiseSayingView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//            wiseSayingView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
//            wiseSayingView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            contentView.addSubview(wiseSayingView)
            wiseSayingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            wiseSayingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            wiseSayingView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            wiseSayingView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            wiseSayingView.createSubviews()
            
//            animation(cardView: wiseSayingView)
            
        case .photoframe:
            let photoFrameView = ExampleCardPhotoFrameView()
//            cardView.addSubview(photoFrameView)
//            photoFrameView.translatesAutoresizingMaskIntoConstraints = false
//            photoFrameView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
//            photoFrameView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//            photoFrameView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
//            photoFrameView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            contentView.addSubview(photoFrameView)
            photoFrameView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            photoFrameView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            photoFrameView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            photoFrameView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            photoFrameView.createSubviews()
//            animation(cardView: photoFrameView)
            
        case .text:
            let textView = ExampleCardTextView()
//            cardView.addSubview(textView)
//            textView.translatesAutoresizingMaskIntoConstraints = false
//            textView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
//            textView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//            textView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
//            textView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            contentView.addSubview(textView)
            
            textView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            textView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            textView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            textView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            textView.createSubviews()
//            animation(cardView: textView)
            
        case .profile:
            let profileView = ExampleCardProfileView()
//            cardView.addSubview(profileView)
//            profileView.translatesAutoresizingMaskIntoConstraints = false
//            profileView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
//            profileView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//            profileView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
//            profileView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
            contentView.addSubview(profileView)
            
            profileView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
            profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
            profileView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
            
            profileView.createSubviews()
//            animation(cardView: profileView)
        }
        
    }
    
//    private func cardViewSetting() {
//        contentView.addSubview(cardView)
//        cardView.translatesAutoresizingMaskIntoConstraints = false
//        cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
//        cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
//        cardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -60).isActive = true
//    }
    
    private func animation(cardView: ExampleCardView) {
        DispatchQueue.main.async {
            cardView.animateStart()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.sublayers?.removeAll()
    }
}
