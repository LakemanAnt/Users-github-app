//
//  AppDelegate.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let screenRect = UIScreen.main.bounds
        window = UIWindow(frame: screenRect)
        
        if let window = self.window {
            let navigationViewController = NavigationViewController()
            window.rootViewController = navigationViewController
            window.makeKeyAndVisible()
        }
       
        return true
    }
}
