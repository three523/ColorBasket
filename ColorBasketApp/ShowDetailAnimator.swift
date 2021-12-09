//
//  ShowDetailAnimator.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/17.
//

import UIKit

let animationScale = UIScreen.main.bounds.width / ((UIScreen.main.bounds.size.width / 2)-5.0)

class DetailAnimationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var originFrame: CGRect?
    var indexPath: IndexPath?
    var mainView: UICollectionView?
    
    let trainsition = ShowDetailAnimator()
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        trainsition.setFrame(frame: originFrame)
        trainsition.indexPath = indexPath
        trainsition.mainView = mainView
        return trainsition
    }
    
    func setFrame(frame: CGRect?) {
        self.originFrame = frame
    }
    
}

class ShowDetailAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect?
    var indexPath: IndexPath?
    var mainView: UICollectionView?
    
    func setFrame(frame: CGRect?) {
        self.originFrame = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from) as UIViewController?
        let toViewController = transitionContext.viewController(forKey: .to) as UIViewController?
        
//        let mainView = (fromViewController as! NTTransitionProtocol).transitionCollection()!
//        let pageView = (toViewController as! NTTransitionProtocol).transitionCollection()!
        
        fromViewController!.view.isHidden = true
        
        guard let toView = toViewController?.view else { return }
        
        guard let orgFrame = originFrame else { return }
        
        containerView.addSubview(toView)
        
        
        let gridView = mainView!.cellForItem(at: indexPath!)

        toViewController!.view.isHidden = true

//        let snapShot = (gridView as! NTTansitionWaterfallGridViewProtocol).snapShotForTransition()
//        containerView.addSubview(snapShot!)
//        snapShot?.frame = orgFrame
//        snapShot?.clipsToBounds = true
//        snapShot?.layer.cornerRadius = 20
//
//        UIView.animate(withDuration: 0.3) {
//            snapShot?.frame.size = CGSize(width: 250, height: 400)
//            snapShot?.center = toViewController!.view.center
//        } completion: { finished in
//            if finished {
//                snapShot?.removeFromSuperview()
////                pageView.isHidden = false
//                toViewController!.view.isHidden = false
//
//                transitionContext.completeTransition(true)
//            }
//        
//        }
    }
}

class cardViewDetailDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var cardView: UIImageView?
    var originImageView: UIImageView?
    
    let transition = cardViewPresentAnimator()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.cardView = cardView
        transition.originImageView = originImageView
        return transition
    }
}

class cardViewPresentAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    var cardView: UIImageView?
    var originImageView: UIImageView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: .to) as UIViewController?
        
        guard let toView = toVC?.view else { return }
                
        guard let cardView = cardView else { return }
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20
        
        containerView.addSubview(toView)
        
        toView.isHidden = true
                        
        containerView.addSubview(cardView)
        originImageView!.isHidden = true
                        
        UIView.animate(withDuration: 0.3, animations: {
            cardView.frame = CGRect(x: cardView.frame.origin.x, y: 0, width: cardView.frame.width, height: cardView.frame.height)
            cardView.alpha = 0
        }, completion: { finished in
            if finished {
                toView.isHidden = false
                cardView.removeFromSuperview()
                self.originImageView!.isHidden = false
                transitionContext.completeTransition(true)
            }
        })
    }
}
