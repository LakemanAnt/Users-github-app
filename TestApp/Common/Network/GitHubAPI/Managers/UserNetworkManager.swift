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
    static let shared = UserManager()
    
    func fetchUsers(lastUserId: Int, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        UserService.shared.fetchUsers(lastUserId: lastUserId, completion: completion)
    }
    
    func fetchUserByLogin(login: String, completion: @escaping (Result<UserInformationModel, Error>) -> Void) {
        UserService.shared.fetchUserByLogin(login: login, completion: completion)
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        UserService.shared.downloadImage(url: url, completion: completion)
    }
}
