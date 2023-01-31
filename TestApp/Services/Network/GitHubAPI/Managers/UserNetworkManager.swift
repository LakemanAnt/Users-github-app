//
//  UserNetworkManager.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import Alamofire
import Foundation
import UIKit

class UserManager: UserNetworkService {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        UserService.shared.fetchUsers(completion: completion)
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        UserService.shared.downloadImage(url: url, completion: completion)
    }
}
