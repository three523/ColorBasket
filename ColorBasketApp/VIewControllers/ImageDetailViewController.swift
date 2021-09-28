//
//  ImageDetailViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/17.
//

import UIKit

class ImageDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NTTransitionProtocol {
    
    var cellInfos: [CellInfo] = []
    var cellSize: CGSize = CGSize(width: 250, height: 400)
    var cellIndex: IndexPath = IndexPath()
    var pullOffset = CGPoint.zero
    let spacing:CGFloat = 20
    
    lazy var detailCollectionView: UICollectionView = {
        let layout = CarouselLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(DetailImageCell.self, forCellWithReuseIdentifier: DetailImageCell.registId)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
                
        view.addSubview(detailCollectionView)
        
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        detailCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailCollectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        detailCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        detailCollectionView.setToIndexPath(cellIndex)
        detailCollectionView.performBatchUpdates({detailCollectionView.reloadData()}, completion: { finished in
            if finished {
                self.detailCollectionView.scrollToItem(at: self.cellIndex,at:.centeredHorizontally, animated: false)
            }});

    }
    
    func addPictureClick(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupCell(cellInfos: [CellInfo], cellIndex: IndexPath, previousIndex: Int) {
        self.cellInfos = cellInfos
        self.cellIndex = cellIndex
    }
    
    func animateZoomforCell(zoomCell: UICollectionViewCell) {
        UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                            zoomCell.transform = .identity }, completion: nil)
    }
    func animateZoomforCellremove(zoomCell: UICollectionViewCell) {
        UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                            zoomCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageCell.registId, for: indexPath) as? DetailImageCell else { return UICollectionViewCell() }
                
        cell.uiImageView.image = HomeViewController.cellInfos[indexPath.item].image
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize.width , height: cellSize.height)
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        let totalCellWidth = Int(cellSize.width) * cellInfos.count
        let totalSpacingWidth = 20 * (cellInfos.count - 1)

        let leftInset = (detailCollectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    
    func transitionCollection() -> UICollectionView! {
        return detailCollectionView
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

class CarouselLayout: UICollectionViewFlowLayout {
    
    public var sideItemScale: CGFloat = 0.7
    public var sideItemAlpha: CGFloat = 0.7
    public var spacing: CGFloat = 10

    public var isPagingEnabled: Bool = false
    
    private var isSetup: Bool = false
    
    override public func prepare() {
        super.prepare()
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    private func setupLayout() {
        guard let collectionView = self.collectionView else {return}
                
        let collectionViewSize = collectionView.bounds.size
        
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let itemWidth = self.itemSize.width
        
        let scaledItemOffset =  (itemWidth - itemWidth*self.sideItemScale) / 2
        self.minimumLineSpacing = spacing - scaledItemOffset

        self.scrollDirection = .horizontal
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else {return attributes}
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)

        let ratio = (maxDistance - distance)/maxDistance

        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        attributes.alpha = alpha
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform
        
        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
