//
//  StringLocalizable.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: NavigationViewController.self), comment: "")
    }
}
