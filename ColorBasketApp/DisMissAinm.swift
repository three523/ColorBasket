//
//  DisMissAinm.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/17.
//

import UIKit

class DisMissAnim: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        UIView.animate(withDuration: 0.2) {
            fromView.alpha = 0.2
        } completion: { success in
            transitionContext.completeTransition(success)
        }

    }
}
