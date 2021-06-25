//
//  ImageDetailViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/17.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var cellInfo: CellInfo?
    var cellSizeInfo: CGRect?
    var cellConstrains: [NSLayoutConstraint]?
    let mainVIew: UIView = UIView()
    let cellView: UIView = UIView()
    let uiImageView: UIImageView = UIImageView()
    let commentView: UIView = UIView()
    let colorInfoButton: UIButton = UIButton()
    let addPictureButton: UIButton = UIButton()
    let heartView: UIImageView = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        uiImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        uiImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        uiImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        
        mainVIew.translatesAutoresizingMaskIntoConstraints = false
        mainVIew.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        UIView.animate(withDuration: 0.4) {
            self.view.backgroundColor = .black
            self.view.layoutIfNeeded()
        } completion: { completed in
            self.uiImageView.layer.masksToBounds = true
            self.uiImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            self.uiImageView.layer.cornerRadius = 20

            self.commentView.isHidden = false
            self.colorInfoButton.isHidden = false
            self.addPictureButton.isHidden = false
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailData = cellInfo else { return }
        guard let cellSize = cellSizeInfo else { return }
        
        cellView.addSubview(uiImageView)
        cellView.layer.cornerRadius = 20
        
        commentView.addSubview(colorInfoButton)
        commentView.addSubview(addPictureButton)
        
        mainVIew.addSubview(cellView)
        mainVIew.addSubview(commentView)
        view.addSubview(mainVIew)
        
        mainVIew.frame = cellSize

        uiImageView.frame.size.width = cellSize.width
        uiImageView.frame.size.height = cellSize.height
        uiImageView.layer.masksToBounds = true
        uiImageView.layer.cornerRadius = 20
        uiImageView.image = detailData.image

        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: mainVIew.topAnchor, constant: 0).isActive = true
        cellView.leadingAnchor.constraint(equalTo: mainVIew.leadingAnchor, constant: 1).isActive = true
        cellView.trailingAnchor.constraint(equalTo: mainVIew.trailingAnchor, constant: -1).isActive = true
        cellView.bottomAnchor.constraint(equalTo: commentView.topAnchor).isActive = true

        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.3).isActive = true
        commentView.leadingAnchor.constraint(equalTo: mainVIew.leadingAnchor).isActive = true
        commentView.trailingAnchor.constraint(equalTo: mainVIew.trailingAnchor).isActive = true
        commentView.bottomAnchor.constraint(equalTo: mainVIew.bottomAnchor).isActive = true
        commentView.backgroundColor = .white

        colorInfoButton.translatesAutoresizingMaskIntoConstraints = false
        colorInfoButton.centerYAnchor.constraint(equalTo: commentView.centerYAnchor, constant: 20).isActive = true
        colorInfoButton.centerXAnchor.constraint(equalTo: commentView.centerXAnchor, constant: -80).isActive = true

        colorInfoButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        colorInfoButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2).isActive = true
        colorInfoButton.backgroundColor = .red
        colorInfoButton.layer.cornerRadius = 20

        addPictureButton.translatesAutoresizingMaskIntoConstraints = false
        addPictureButton.centerYAnchor.constraint(equalTo: colorInfoButton.centerYAnchor).isActive = true
        addPictureButton.centerXAnchor.constraint(equalTo: commentView.centerXAnchor, constant: 80).isActive = true
        addPictureButton.heightAnchor.constraint(equalTo: colorInfoButton.heightAnchor).isActive = true
        addPictureButton.widthAnchor.constraint(equalTo: colorInfoButton.widthAnchor).isActive = true
        addPictureButton.backgroundColor = .lightGray
        addPictureButton.layer.cornerRadius = 20
        addPictureButton.addTarget(self, action: #selector(addPictureClick(_:)), for: .touchUpInside)
        
        commentView.isHidden = true
        colorInfoButton.isHidden = true
        addPictureButton.isHidden = true

    }
    
    @objc
    func addPictureClick(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
