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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth - 120, height: collectionView.frame.size.height - 40)
    }
        
    var seletedImageView: UIImageView = UIImageView()
    lazy var collectionView: UICollectionView = {
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: CardFlowLayout())
        let cv = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout())
        cv.decelerationRate = .fast
        cv.delegate = self
        cv.dataSource = self
        cv.register(ExampleCardCollectionViewCell.self, forCellWithReuseIdentifier: ExampleCardCollectionViewCell.registerID)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
        return cv
    }()
    let colorListView: ColorListView = {
        let clv = ColorListView()
        clv.axis = .vertical
        clv.alignment = .fill
        clv.distribution = .fillEqually
        return clv
    }()
    var colorList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(colorListView)
        collectionViewSetting()
        setupView()
    }
    var colorViewModel = CardViewModel()
    
    func collectionViewSetting() {
        view.backgroundColor = UIColor(hexFromString: "EFEEEE")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        CardViewModel.cardCollection = { self.collectionView.reloadData()
        }
    }
    
    func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = UIColor(hexFromString: "EFEEEE")
        colorListView.translatesAutoresizingMaskIntoConstraints = false
        colorListView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15).isActive = true
        colorListView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        colorListView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        colorListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        colorListView.uiSetting(colorList: colorList)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        let indexPath = collectionView.indexPathForItem(at: center)!
         collectionView.cellForItem(at: indexPath)
        let index = indexPath.item
        
        colorListView.selectClear(index: index)
    }
}

//class CardFlowLayout: UICollectionViewFlowLayout {
//    let xInset: CGFloat = 40
//
//    override func prepare() {
//        super.prepare()
//        setupLayout()
//    }
//    private func setupLayout() {
//        guard let collectionView = collectionView else { return }
//
////        let collectionViewSize = collectionView.bounds.size
////        let xInset = (collectionViewSize.width - self.itemSize.width)/2
////        self.estimatedItemSize = .zero
//        self.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
//
//        self.scrollDirection = .horizontal
//    }
//}

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
