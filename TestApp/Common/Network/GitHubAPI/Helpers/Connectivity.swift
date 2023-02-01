//
//  Connectivity.swift
//  TestApp
//
//  Created by Anton on 01.02.2023.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
