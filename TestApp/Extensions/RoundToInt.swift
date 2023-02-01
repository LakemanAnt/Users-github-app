//
//  RoundToInt.swift
//  TestApp
//
//  Created by Anton on 01.02.2023.
//

import CoreFoundation

extension CGFloat {
    func roundToInt() -> CGFloat {
        let divisor = pow(10.0, CGFloat(0))
        return (self * divisor).rounded() / divisor
    }
}
