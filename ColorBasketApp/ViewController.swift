//
//  ViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imageCollectionView: UICollectionView?
    var imageSearchController = UISearchController(searchResultsController: nil)
    var cellInfos: [CellInfo] = []
    var isLoading = false
    var count = 0
    let transition = ShowDetailAnimator()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        if cellInfos.count == 0 {
            self.getCellData(type: 2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshContoller = UIRefreshControl()
        refreshContoller.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        let tabBarView = UITabBarView()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        
        imageCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        
        guard let mainImageCollectionView = imageCollectionView else { return }
        
//        imageSearchController = UISearchController(searchResultsController: nil )
        imageSearchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = imageSearchController
        
        
        mainImageCollectionView.backgroundColor = .white
        mainImageCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainImageCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(mainImageCollectionView)
        view.addSubview(tabBarView)
        mainImageCollectionView.refreshControl = refreshContoller
        tabBarView.setupView()
        
        mainImageCollectionView.delegate = self
        mainImageCollectionView.dataSource = self
        mainImageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.registerId)
        mainImageCollectionView.register(MoreData.self, forCellWithReuseIdentifier: MoreData.registerId)
        
    }
    
    @objc
    func refreshData() {
        getCellData(type: 1)
    }
    
    func stopRefresher() {
        self.imageCollectionView?.refreshControl?.endRefreshing()
    }
    
    func getCellData(type: Int) {
        
        cellInfos = type == 1 ? [] : cellInfos
        
        if type == 3 {
            isLoading = true
        }
                
        var serverDatas:[ServerData] = []
        guard let url = URL(string: "https://api.colorbasket.shop/api/photo") else { return }
        
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
//                print("카운트 \(serverDatas.count)")
                for serverData in serverDatas {
                    guard let imageUrl: URL = URL(string: serverData.url) else { return }
                    
                    do {
                        let imageData = try Data(contentsOf: imageUrl)
                        guard let image = UIImage(data: imageData) else { return }
//                        self.cellInfos.append(CellInfo(image: image, title: serverData.title ?? "no title", color: serverData.color ))
                        self.cellInfos.append(CellInfo(image: image, title: serverData.title ?? "no title" ))
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                DispatchQueue.main.async {
                    self.imageCollectionView?.reloadData()
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
            return cellInfos.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.registerId, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = nil

            if cellInfos.count == 0 {
                return cell
            }
            
            if cellInfos.count < indexPath.item {
                return cell
            }

            DispatchQueue.main.async {
                cell.imageView.image = self.cellInfos[indexPath.item].image
            }
            
            cell.titleLabel.text = cellInfos[indexPath.item].title
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
        guard let toVC = storyboard?.instantiateViewController(identifier: "ImageDetailViewController") as? ImageDetailViewController else {
            return
        }
        
        toVC.transitioningDelegate = self
        toVC.modalPresentationStyle = .custom
        toVC.cellInfo = cellInfos[indexPath.item]
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        let cellOriginPoint = cell.superview?.convert(cell.center, to: nil)
        let cellOriginFrame = cell.superview?.convert(cell.frame, to: nil)
        
        transition.setPoint(point: cellOriginPoint)
        transition.setFrame(frame: cellOriginFrame)
        
        present(toVC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading && cellInfos.count != 0 {
            DispatchQueue.main.async {
                self.getCellData(type: 3)
            }
        }
    }

}

extension ViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DisMissAnim()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

