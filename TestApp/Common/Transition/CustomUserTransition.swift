//
//  CustomUserTransition.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class CustomUserTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private var sourceFrame: CGRect
    private var isPresenting: Bool

    init(sourceFrame: CGRect, isPresenting: Bool) {
        self.sourceFrame = sourceFrame
        self.isPresenting = isPresenting
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentationAnimation(using: transitionContext)
        } else {
            dismissingAnimation(using: transitionContext)
        }
    }

    func presentationAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to) as! UserView
        toView.closeButton.isHidden = true
        toView.avatarImageView.isHidden = true
        toView.informationTableView.isHidden = true
        toView.topDividingLineView.isHidden = true
        toView.loginLabel.isHidden = true
        toView.frame = sourceFrame
        toView.alpha = 0.3
        containerView.addSubview(toView)
        let transitionDurationValue = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDurationValue, animations: {
            toView.alpha = 1
            toView.frame = containerView.bounds
        }, completion: { _ in
            toView.closeButton.isHidden = false
            toView.avatarImageView.isHidden = false
            toView.informationTableView.isHidden = false
            toView.topDividingLineView.isHidden = false
            toView.loginLabel.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func dismissingAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from) as! UserView
        let transitionDurationValue = transitionDuration(using: transitionContext)
        fromView.closeButton.isHidden = true
        fromView.topDividingLineView.isHidden = true
        fromView.avatarImageView.isHidden = true
        fromView.informationTableView.isHidden = true
        fromView.loginLabel.isHidden = true
        UIView.animate(withDuration: transitionDurationValue, animations: {
            fromView.frame = self.sourceFrame
            fromView.alpha = 0.3
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
