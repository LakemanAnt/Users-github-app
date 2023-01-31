//
//  NavigationViewController.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewComtroller()
    }

    private func initViewComtroller() {
        isNavigationBarHidden = true
        let mainViewController = MainViewController()
        viewControllers = [mainViewController]
    }
}
