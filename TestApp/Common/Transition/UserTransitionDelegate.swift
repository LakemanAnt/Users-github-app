//
//  UserTransitionDelegate.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class UserTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    static private var sourceFrame: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    
    init(sourceFrame: CGRect) {
        UserTransitionDelegate.sourceFrame = sourceFrame
    }
    
    override init() {
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomUserTransition(sourceFrame: UserTransitionDelegate.sourceFrame, isPresenting: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomUserTransition(sourceFrame: UserTransitionDelegate.sourceFrame, isPresenting: true)
    }
    
}
