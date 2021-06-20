//
//  ShowDetailAnimator.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/17.
//

import UIKit

//class ShowDetailAnimator: NSObject {
//
//}

class ShowDetailAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    var originPoint: CGPoint?
    var originFrame: CGRect?
    
    func setPoint(point: CGPoint?) {
        self.originPoint = point
    }
    
    func setFrame(frame: CGRect?) {
        self.originFrame = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let orgFrame = originFrame else { return }

        toView.frame = orgFrame
        toView.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20
        toView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            toView.transform = .identity
            toView.alpha = 1
        }) { _ in
            
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            
            UIView.animate(withDuration: 1) {
                containerView.layoutIfNeeded()
            }
        }

//        let duration = transitionDuration(using: transitionContext)
//        let frame = transitionContext.finalFrame(for: toVC)
//
//        toVC.uiTitleLabel.alpha = 0.0
//
//        UIView.animate(withDuration: duration) {
//            toVC.uiTitleLabel.alpha = 1.0
//            toView.frame = frame
//            toView.transform = .identity
//            toView.layoutIfNeeded()
//        } completion: { success in
//            transitionContext.completeTransition(true)
//        }
        
        transitionContext.completeTransition(true)

    }
}
