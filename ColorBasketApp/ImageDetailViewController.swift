//
//  ImageDetailViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/17.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var cellInfo: CellInfo?
//    let cellView: UIView = UIView()
//    let uiImageView: UIImageView = UIImageView()
//    let uiTitleLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .black
//        cellView.addSubview(uiImageView)
//        cellView.addSubview(uiTitleLabel)
//        view.addSubview(cellView)
//
//        cellView.translatesAutoresizingMaskIntoConstraints = false
//        cellView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        cellView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        cellView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        uiImageView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
//        uiImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
//        uiImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
//        uiImageView.bottomAnchor.constraint(equalTo: uiTitleLabel.topAnchor).isActive = true
//
//        uiTitleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
//        uiTitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
//        uiTitleLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        uiImageView.image = cellInfo?.image
//        uiTitleLabel.text = cellInfo?.title
    }
}
