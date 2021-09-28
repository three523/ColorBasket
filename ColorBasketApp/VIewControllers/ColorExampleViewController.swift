//
//  ColorExampleViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/13.
//

import UIKit

class ColorExampleViewController: UIViewController {
    
    var seletedImageView: UIImageView = UIImageView()
    let exampleCV: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return cv
    }()
    var exampleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(seletedImageView)
        exampleView.addSubview(exampleCV)
        view.addSubview(exampleView)

        seletedImageView.frame = CGRect(x: 0, y: -200, width: view.frame.width, height: 500)
        exampleView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height - 200)
        
        exampleCV.translatesAutoresizingMaskIntoConstraints = false
        exampleCV.centerYAnchor.constraint(equalTo: exampleView.centerYAnchor).isActive = true
        exampleCV.heightAnchor.constraint(equalToConstant: 400).isActive = true
        exampleCV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        exampleCV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(click))
        exampleView.addGestureRecognizer(tap)

    }
    
    @objc func click() {
        print("DAdada")
        dismiss(animated: true, completion: nil)
    }

}
