//
//  UITabBarView.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit

class UITabBarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        let stackView = UIStackView()
        let houseView = UIView()
        let searchView = UIView()
        let heartView = UIView()
        
        let widthConstant:CGFloat = 22
        let heightConstant:CGFloat = 10
        let fontSize:CGFloat = 12
               
        let houseImageView = UIImageView(image: UIImage(systemName: "house"))
        houseImageView.tintColor = .gray
        let houseLabel = UILabel()
        houseLabel.text = "홈"
        houseLabel.textColor = .gray
        houseLabel.textAlignment = .center
        houseLabel.font = .systemFont(ofSize: fontSize)
        
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = .gray
        let searchLabel = UILabel()
        searchLabel.text = "검색"
        searchLabel.textColor = .gray
        searchLabel.textAlignment = .center
        searchLabel.font = .systemFont(ofSize: fontSize)
        
        let heartImageView = UIImageView(image: UIImage(systemName: "heart"))
        heartImageView.tintColor = .gray
        let heartLabel = UILabel()
        heartLabel.text = "좋아요"
        heartLabel.textColor = .gray
        heartLabel.textAlignment = .center
        heartLabel.font = .systemFont(ofSize: fontSize)
        
        houseView.addSubview(houseImageView)
        houseView.addSubview(houseLabel)
        
        searchView.addSubview(searchImageView)
        searchView.addSubview(searchLabel)
        
        heartView.addSubview(heartImageView)
        heartView.addSubview(heartLabel)
        
        stackView.addArrangedSubview(houseView)
        stackView.addArrangedSubview(searchView)
        stackView.addArrangedSubview(heartView)
        self.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
//        NSLayoutConstraint(item: houseView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/3, constant: 0).isActive = true
//        NSLayoutConstraint(item: houseImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/3, constant: 0).isActive = true
//        NSLayoutConstraint(item: houseImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/3, constant: 0).isActive = true
        
        houseView.translatesAutoresizingMaskIntoConstraints = false
        houseView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        houseView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        houseView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        houseImageView.translatesAutoresizingMaskIntoConstraints = false

//        NSLayoutConstraint(item: houseImageView, attribute: .height, relatedBy: .equal, toItem: houseView, attribute: .height, multiplier: 0.8, constant: 0).isActive = true
        houseImageView.topAnchor.constraint(equalTo: houseView.topAnchor, constant: heightConstant).isActive = true
        houseImageView.leadingAnchor.constraint(equalTo: houseView.leadingAnchor, constant: widthConstant).isActive = true
        houseImageView.trailingAnchor.constraint(equalTo: houseView.trailingAnchor, constant: -widthConstant).isActive = true

        houseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: houseLabel, attribute: .height, relatedBy: .equal, toItem: houseView, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        houseLabel.topAnchor.constraint(equalTo: houseImageView.bottomAnchor).isActive = true
        houseLabel.leadingAnchor.constraint(equalTo: houseView.leadingAnchor, constant: widthConstant).isActive = true
        houseLabel.trailingAnchor.constraint(equalTo: houseView.trailingAnchor, constant: -widthConstant).isActive = true
        houseLabel.bottomAnchor.constraint(equalTo: houseView.bottomAnchor, constant: -heightConstant).isActive = true

        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: houseView.trailingAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

        searchImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint(item: searchImageView, attribute: .height, relatedBy: .equal, toItem: searchView, attribute: .height, multiplier: 0.8, constant: 0).isActive = true
        searchImageView.topAnchor.constraint(equalTo: searchView.topAnchor, constant: heightConstant).isActive = true
        searchImageView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: widthConstant).isActive = true
        searchImageView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -widthConstant).isActive = true

        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: searchLabel, attribute: .height, relatedBy: .equal, toItem: searchView, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        searchLabel.topAnchor.constraint(equalTo: searchImageView.bottomAnchor).isActive = true
        searchLabel.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: widthConstant).isActive = true
        searchLabel.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -widthConstant).isActive = true
        searchLabel.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -heightConstant).isActive = true

        heartView.translatesAutoresizingMaskIntoConstraints = false
        heartView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        heartView.leadingAnchor.constraint(equalTo: searchView.trailingAnchor).isActive = true
        heartView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        heartView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

        heartImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint(item: heartImageView, attribute: .height, relatedBy: .equal, toItem: heartView, attribute: .height, multiplier: 0.8, constant: 0).isActive = true
        heartImageView.topAnchor.constraint(equalTo: heartView.topAnchor, constant: heightConstant).isActive = true
        heartImageView.leadingAnchor.constraint(equalTo: heartView.leadingAnchor,constant: widthConstant).isActive = true
        heartImageView.trailingAnchor.constraint(equalTo: heartView.trailingAnchor, constant: -widthConstant).isActive = true

        heartLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: heartLabel, attribute: .height, relatedBy: .equal, toItem: heartView, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        heartLabel.topAnchor.constraint(equalTo: heartImageView.bottomAnchor).isActive = true
        heartLabel.leadingAnchor.constraint(equalTo: heartView.leadingAnchor, constant: widthConstant).isActive = true
        heartLabel.trailingAnchor.constraint(equalTo: heartView.trailingAnchor, constant: -widthConstant).isActive = true
        heartLabel.bottomAnchor.constraint(equalTo: heartView.bottomAnchor, constant: -heightConstant).isActive = true
        
        guard let rootView = superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 70).isActive = true
        self.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -70).isActive = true
        self.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -20).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
    }
}
