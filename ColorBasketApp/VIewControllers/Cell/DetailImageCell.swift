//
//  DetailImageCell.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/25.
//

import UIKit

class ColorCollectionCell: UICollectionViewCell {
    
    static let registId: String = "\(ColorCollectionCell.self)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum CardState: Int {
    case small, medium, lazy
}

class DetailImageCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let registId: String = "\(DetailImageCell.self)"
    let cardView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.5
        return view
    }()
    let cardImageView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        return img
    }()
    var pictureColor: [String] = []
    let cardDetailView: UIView = UIView()
    var cardState: CardState = .small
    var cardViewConstraintMediumYAnchor: NSLayoutConstraint?
    var cardViewConstraintCenterYAnchor: NSLayoutConstraint?
    var cardViewConstraintLazyAnchor: NSLayoutConstraint?
    var cellDelegate: CVCellDelgate?
    
    var nextCell: UICollectionViewCell?
    var prevCell: UICollectionViewCell?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    func uiSetting() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        swipeUpGesture.direction = .up
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeDownGesture.direction = .down
        
        cardView.addGestureRecognizer(swipeUpGesture)
        cardView.addGestureRecognizer(swipeDownGesture)
        contentView.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
        cardView.addSubview(cardImageView)
        contentView.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardViewConstraintCenterYAnchor = cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        cardViewConstraintMediumYAnchor = cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80)
        
        cardViewConstraintCenterYAnchor?.isActive = true
        cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        cardImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func swipeDown(_ sender: UISwipeGestureRecognizer) {
        guard cardState.rawValue != 0 else { return }
        
        cardState = CardState(rawValue: cardState.rawValue - 1)!
        
        switch cardState {
        case .small:
            defaultCard(visibleAnimation: true)
        case .medium:
            createCardColorView()
        case .lazy: break
        default:
            break
        }
    }
    
    @objc func swipeUp(_ sender: UISwipeGestureRecognizer) {
        guard cardState.rawValue != 2 else { return }
        
        cardState = CardState(rawValue: cardState.rawValue + 1)!
        
        switch cardState {
        case .small: break
        case .medium:
            createCardColorView()
        case .lazy:
            detailColorList()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionCell.registId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (cardView.bounds.width/6) - 35
        let height: CGFloat = collectionView.bounds.height - 10
        
        return CGSize(width: width, height: height)
    }
    
    func defaultCard(visibleAnimation: Bool) {
        
        guard let delegate = cellDelegate else { return }
        delegate.collectionViewScrollEnabled(enable: true)
        
        cardViewConstraintMediumYAnchor?.isActive = false
        cardViewConstraintCenterYAnchor?.isActive = true
        
        let nextCellScaleAndPoint = nextCell!.transform.translatedBy(x: -100, y: 0)
        let prevCellScaleAndPoint = prevCell!.transform.translatedBy(x: 100, y: 0)
        
        if visibleAnimation {
            UIView.animate(withDuration: 0.5, animations: {
                self.nextCell?.transform = nextCellScaleAndPoint
                self.prevCell?.transform = prevCellScaleAndPoint
                self.cardDetailView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.layoutIfNeeded()
            }, completion: { _ in
                self.cardDetailView.removeFromSuperview()
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.cardDetailView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.layoutIfNeeded()
            }, completion: { _ in
                self.nextCell?.transform = nextCellScaleAndPoint
                self.prevCell?.transform = prevCellScaleAndPoint
                self.cardDetailView.removeFromSuperview()
            })
        }
    }
    
    func createCardColorView() {
        
        guard let delegate = cellDelegate else { return }
        delegate.collectionViewScrollEnabled(enable: false)
        
        let colorListView: UIStackView = {
            let vst = UIStackView()
            vst.axis = .vertical
            vst.distribution = .fillEqually
            vst.alignment = .fill
            return vst
        }()
        let horizontalTopView: UIStackView = {
            let hst = UIStackView()
            hst.axis = .horizontal
            hst.distribution = .fillEqually
            hst.alignment = .fill
            return hst
        }()
        let horizontalBottomView: UIStackView = {
            let hst = UIStackView()
            hst.axis = .horizontal
            hst.distribution = .fillEqually
            hst.alignment = .fill
            return hst
        }()
        
        for i in 1...2 {
            for j in 1...3 {
                let colorView = UIView()
                colorView.clipsToBounds = true
                colorView.layer.cornerRadius = 0.5 * colorView.bounds.size.width
                colorView.backgroundColor = UIColor(hexFromString: pictureColor[i*j])
                
                i == 1 ? horizontalTopView.addArrangedSubview(colorView) : horizontalBottomView.addArrangedSubview(colorView)
            }
        }
        colorListView.addArrangedSubview(horizontalBottomView)
        colorListView.addArrangedSubview(horizontalTopView)
        colorListView.center = contentView.center
        
        cardDetailView.addSubview(colorListView)
        cardDetailView.frame = cardView.frame
        cardDetailView.center = contentView.center
        cardDetailView.backgroundColor = .white
        cardDetailView.clipsToBounds = true
        cardDetailView.layer.cornerRadius = 10
        
        contentView.addSubview(cardDetailView)
        contentView.sendSubviewToBack(cardDetailView)
        
        cardDetailView.translatesAutoresizingMaskIntoConstraints = false
        cardDetailView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 60).isActive = true
        cardDetailView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: -30).isActive = true
        cardDetailView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 30).isActive = true
        cardDetailView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 100).isActive = true
        cardDetailView.backgroundColor = .white
        cardDetailView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        colorListView.translatesAutoresizingMaskIntoConstraints = false
        colorListView.topAnchor.constraint(equalTo: self.cardImageView.bottomAnchor, constant: 10).isActive = true
        colorListView.leadingAnchor.constraint(equalTo: self.cardDetailView.leadingAnchor).isActive = true
        colorListView.trailingAnchor.constraint(equalTo: self.cardDetailView.trailingAnchor).isActive = true
        colorListView.bottomAnchor.constraint(equalTo: self.cardDetailView.bottomAnchor).isActive = true
        
        self.layoutIfNeeded()
        
        cardViewConstraintCenterYAnchor?.isActive = false
        cardViewConstraintMediumYAnchor?.isActive = true
        
        guard let cv = superview as? UICollectionView else { return }
        let indexPath = cv.indexPath(for: self)!
        let nextIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        nextCell = cv.cellForItem(at: nextIndexPath)
        prevCell = cv.cellForItem(at: previousIndexPath)
        
        nextCell?.transform = .identity
        prevCell?.transform = .identity
        nextCell?.transform = nextCell!.transform.scaledBy(x: 0.7, y: 0.7)
        prevCell?.transform = prevCell!.transform.scaledBy(x: 0.7, y: 0.7)
        
        let nextCellTransform = nextCell!.transform.translatedBy(x: 100, y: 0)
        let prevCellTransform = prevCell!.transform.translatedBy(x: -100, y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
            self.nextCell?.transform = nextCellTransform
            self.prevCell?.transform = prevCellTransform
            self.cardDetailView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func detailColorList() {
        if let delegate = cellDelegate {
            let cellImageView = UIImageView(image: cardImageView.image)
            let originFrame = self.convert(cardView.frame, to: nil)
            cellImageView.frame = originFrame
            delegate.swipeCellPresent(cellImageView: cellImageView, originCellImageView: cardImageView)
            cardState = .small
            defaultCard(visibleAnimation: false)
        }
    }

}

extension UIColor {
    convenience init?(hexFromString:String, alpha:CGFloat = 1.0) {
        guard hexFromString.count == 6 else { return nil }
        
        let cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329

        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
