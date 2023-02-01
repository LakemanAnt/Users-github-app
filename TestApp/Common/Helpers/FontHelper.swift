//
//  FontHelper.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

enum Gilroy: String {
    case semibold = "Gilroy-Semibold"
    case bold = "Gilroy-Bold"
}

extension UIFont {
    static func Gilroy(type: Gilroy, ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: ofSize) {
            return font
        } else {
            return .systemFont(ofSize: ofSize)
        }
    }
}
