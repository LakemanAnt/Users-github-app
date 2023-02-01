//
//  ColorHelper.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

enum CustomColor: String {
    case gray = "Gray"
    case purple = "Purple"
    case blueGray = "BlueGray"
}

extension UIColor {
    static func Custom(type: CustomColor) -> UIColor {
        if let color = UIColor(named: type.rawValue) {
            return color
        } else {
            return .clear
        }
    }
}
