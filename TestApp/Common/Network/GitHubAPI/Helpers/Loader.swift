//
//  Loader.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class Loader {
    static private var containerView = UIView()
    static private var progressView = UIActivityIndicatorView()
    
    static func showProgressView() {
        DispatchQueue.main.async {
            guard let topViewController = UIApplication.topViewController() else {
                return
            }
            guard let view = topViewController.view else {
                return
            }
            containerView.frame = view.frame
            containerView.center = view.center
            containerView.backgroundColor = UIColor.clear
            
            progressView.color = .Custom(type: .purple)
            progressView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            progressView.style = .large
            progressView.center = CGPoint(x: containerView.frame.size.width / 2, y: containerView.frame.size.height / 2)
            
            containerView.addSubview(progressView)
            view.addSubview(containerView)
            progressView.startAnimating()
        }
    }
    
    static func hideProgressView() {
        DispatchQueue.main.async {
            progressView.stopAnimating()
            containerView.removeFromSuperview()
        }
    }
}
