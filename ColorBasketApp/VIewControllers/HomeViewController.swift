//
//  HomeViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/02.
//

import UIKit

import UIKit

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, NTTransitionProtocol {
    
    var imageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
    var imageSearchController = UISearchController(searchResultsController: nil)
    static var cellInfos: [CellInfo] = []
    var isLoading = false
    var count = 0
    let transition = DetailAnimationDelegate()
    var selectedCell: UIView?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        if HomeViewController.cellInfos.count == 0 {
            self.getCellData(type: 2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let refreshContoller = UIRefreshControl()
        refreshContoller.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.navigationController?.delegate = self
                
        let tabBarView = UITabBarView()
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
        view.addSubview(tabBarView)
        imageCollectionView.refreshControl = refreshContoller
        tabBarView.setupView()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.registerId)
        imageCollectionView.register(MoreData.self, forCellWithReuseIdentifier: MoreData.registerId)
        
    }
    
    @objc
    func refreshData() {
        getCellData(type: 1)
    }
    
    func stopRefresher() {
        self.imageCollectionView.refreshControl?.endRefreshing()
    }
    
    func getCellData(type: Int) {
        
        HomeViewController.cellInfos = type == 1 ? [] : HomeViewController.cellInfos
        
        if type == 3 {
            isLoading = true
        }
                
        var serverDatas:[ServerData] = []
        guard let url = URL(string: "https://colorbasketapi.herokuapp.com/api/photo") else { return }
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { [self] (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                serverDatas = apiResponse.data
                print(serverDatas)
                for serverData in serverDatas {
                    guard let imageUrl: URL = URL(string: serverData.url) else { return }
                    
                    do {
                        let imageData = try Data(contentsOf: imageUrl)
                        guard let image = UIImage(data: imageData) else { return }
                        HomeViewController.cellInfos.append(CellInfo(image: image, title: serverData.title ?? "no title" , color: serverData.color))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                DispatchQueue.main.async {
                    self.imageCollectionView.reloadData()
                    isLoading = false
                    stopRefresher()
                }
                print("aaaa")
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        dataTask.resume()
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
            return HomeViewController.cellInfos.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.registerId, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = nil

            if HomeViewController.cellInfos.count == 0 {
                return cell
            }
            
            if HomeViewController.cellInfos.count < indexPath.item {
                return cell
            }

            DispatchQueue.main.async {
                cell.imageView.image = HomeViewController.cellInfos[indexPath.item].image
            }
            
            cell.titleLabel.text = HomeViewController.cellInfos[indexPath.item].title
            cell.layer.cornerRadius = 10

            return cell
        } else {
            
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreData.registerId, for: indexPath) as? MoreData else {
                return MoreData()
            }
            if isLoading {
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
                
        toVC.cellInfos = HomeViewController.cellInfos
        toVC.cellIndex = indexPath
        
        transition.originFrame = cellOriginFrame
        transition.indexPath = indexPath
        transition.mainView = imageCollectionView
        
        toVC.transitioningDelegate = transition
        toVC.modalPresentationStyle = .custom
        
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

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading && HomeViewController.cellInfos.count != 0 {
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


@objc protocol NTTransitionProtocol {
    func transitionCollection() -> UICollectionView!
}

@objc protocol NTTansitionWaterfallGridViewProtocol{
    func snapShotForTransition() -> UIView!
}

