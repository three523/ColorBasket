//
//  ColorExampleViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/13.
//

import UIKit

class ColorExampleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCardCollectionViewCell.registerID, for: indexPath) as? ExampleCardCollectionViewCell else { return UICollectionViewCell()}
        
        let mode = ExampleCardMode.init(rawValue: indexPath.item) ?? .basket
        cell.settings(mode: mode)
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
//                cell.center.y += 50
//            }
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth - 120, height: collectionView.frame.size.height - 40)
    }
    
    let cardview = ExampleCardBasketCardView()
    var seletedImageView: UIImageView = UIImageView()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: CardFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(ExampleCardCollectionViewCell.self, forCellWithReuseIdentifier: ExampleCardCollectionViewCell.registerID)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionViewSetting()
//        setupView()
//        cardview.createSubviews()
    }
    
    func collectionViewSetting() {
        view.backgroundColor = UIColor(hexFromString: "EFEEEE")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
    }
    
    func setupView() {
        view.backgroundColor = UIColor(hexFromString: "EFEEEE")
        view.addSubview(cardview)
        cardview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardview.heightAnchor.constraint(equalToConstant: 400).isActive = true
        cardview.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
}

class CardFlowLayout: UICollectionViewFlowLayout {
    let xInset: CGFloat = 40
    
    override func prepare() {
        super.prepare()
        setupLayout()
    }
    private func setupLayout() {
        guard let collectionView = collectionView else { return }
        
//        let collectionViewSize = collectionView.bounds.size
//        let xInset = (collectionViewSize.width - self.itemSize.width)/2
//        self.estimatedItemSize = .zero
        self.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
        
        self.scrollDirection = .horizontal
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)

struct ColorExampleViewControllerRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        return ColorExampleViewController().view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

struct ColorExampleVCPreview: PreviewProvider {
    static var previews: some View {
        ColorExampleViewControllerRepresentable()
            .previewDevice("iPhone 12 Pro")
    }
}

#endif
