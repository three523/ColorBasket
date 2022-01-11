//
//  HomeViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/02.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    
    var imageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
    var imageSearchController = UISearchController(searchResultsController: nil)
    var viewModel: HomeViewModel = HomeViewModel()
    var isLoading = false
    var count = 0
    let transition = DetailAnimationDelegate()
    var selectedCell: UIView?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        if viewModel.getCount() == 0 {
            viewModel.imageCollection = {self.imageCollectionView.reloadData()}
            self.getCellData(type: 2)
            self.imageCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let refreshContoller = UIRefreshControl()
        refreshContoller.addTarget(self, action: #selector(refreshData), for: .valueChanged)
                
        self.navigationController?.delegate = self
                
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        
        imageCollectionView.frame = self.view.frame
        imageCollectionView.collectionViewLayout = collectionViewLayout
                
        imageSearchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = imageSearchController
        
        imageCollectionView.backgroundColor = .white
        imageCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        imageCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(imageCollectionView)
        imageCollectionView.refreshControl = refreshContoller
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.registerId)
        imageCollectionView.register(LodingView.self, forCellWithReuseIdentifier: LodingView.registerId)
        
        
    }
    
    @objc
    func refreshData() {
        getCellData(type: 1)
    }
    
    func stopRefresher() {
        self.imageCollectionView.refreshControl?.endRefreshing()
    }
    
    func getCellData(type: Int) {
        
        switch type {
            case 1:
                viewModel.refresh()
            case 3:
                isLoading = true
            default:
                viewModel.list()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let width = collectionView.frame.width
            
            let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            let itemsPerRow: CGFloat = 2
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            
            let cellWidth = (width - widthPadding) / itemsPerRow
             
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModel.getCount()
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.registerId, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = nil
            
            if viewModel.getCount() == 0 {
                return cell
            }
            
            if viewModel.getCount() < indexPath.item {
                return cell
            }
            
            let cellInfo = viewModel.getData(index: indexPath.item)
            cell.setImage(cellInfo)
            
            cell.layer.cornerRadius = 10

            return cell
        } else {
            
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LodingView.registerId, for: indexPath) as? LodingView else {
                return LodingView()
            }
            if isLoading {
                viewModel.stopLoading = {
                    DispatchQueue.main.async {
                        cell.indicatorView.stopAnimating()
                        self.isLoading = false
                    }
                }
                
                // TODO: 셀 추가 생성후 인디케이터 제거하기
                cell.indicatorView.startAnimating()
            }

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let toVC = ImageDetailViewController()
                        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
                
        var cellOriginFrame = cell.superview?.convert(cell.frame, to: nil)
        
        cellOriginFrame?.size.height += 10
        cellOriginFrame?.size.width += 10
                
        toVC.viewModel = viewModel
        toVC.cellIndex = indexPath
        
        transition.originFrame = cellOriginFrame
        transition.indexPath = indexPath
        transition.mainView = imageCollectionView
        
//        toVC.transitioningDelegate = transition
//        toVC.modalPresentationStyle = .custom
        
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    func pageViewControllerLayout () -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading && viewModel.getCount() != 0 {
            DispatchQueue.main.async {
                self.getCellData(type: 3)
            }
        }
    }
    
    func transitionCollection() -> UICollectionView! {
        return imageCollectionView
    }
}
extension UIView {
    func origin (_ point: CGPoint) {
        frame.origin.x = point.x
        frame.origin.y = point.y
    }
}

var kIndexPathPointer = "kIndexPathPointer"

extension UICollectionView {
    
    func setToIndexPath (_ indexPath : IndexPath){
        objc_setAssociatedObject(self, &kIndexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func toIndexPath () -> IndexPath {
        let index = self.contentOffset.x/self.frame.size.width
        if index > 0{
            return IndexPath(row: Int(index), section: 0)
        }else if let indexPath = objc_getAssociatedObject(self,&kIndexPathPointer) as? IndexPath {
            return indexPath
        }else{
            return IndexPath(row: 0, section: 0)
        }
    }
    
    func fromPageIndexPath () -> IndexPath{
        let index : Int = Int(self.contentOffset.x/self.frame.size.width)
        return IndexPath(row: index, section: 0)
    }
}

extension UIImageView {
    public func imageFromURL(urlString: String, placeholder: UIImage?, completion: @escaping () -> ()) {
        if self.image == nil {
            self.image = placeholder
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                self.setNeedsLayout()
                completion()
            })
        }).resume()
    }
}
