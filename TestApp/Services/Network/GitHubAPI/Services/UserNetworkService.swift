//
//  UserNetworkManager.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import Foundation
import Alamofire
import UIKit
import Kingfisher

protocol UserNetworkService {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class UserService {
    static let shared = UserService()
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.usersEndpoint) else {
            completion(.failure(AFError.invalidURL(url: APIConstants.baseURL + APIConstants.usersEndpoint)))
            return
        }
        AF.request(url, method: .get).responseDecodable(of: [User].self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageUrl = URL(string: url)!
        KingfisherManager.shared.retrieveImage(with: imageUrl) { result in
            switch result {
            case .success(let imageResult):
                completion(.success(imageResult.image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
