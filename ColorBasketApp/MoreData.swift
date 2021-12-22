//
//  MoreData.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/13.
//

import UIKit

class LodingView: UICollectionViewCell {
    
    var indicatorView = UIActivityIndicatorView()
    static let registerId = "\(LodingView.self)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(indicatorView)

        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
