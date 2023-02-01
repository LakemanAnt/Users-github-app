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
    func fetchUsers(lastUserId: Int,completion: @escaping (Result<[UserModel], Error>) -> Void)
    func fetchUserByLogin(login: String ,completion: @escaping (Result<UserInformationModel, Error>) -> Void)
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class UserService {
    static let shared = UserService()
    
    func fetchUsers(lastUserId: Int, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.usersEndpoint + String(lastUserId)) else {
            completion(.failure(AFError.invalidURL(url: APIConstants.baseURL + APIConstants.usersEndpoint)))
            return
        }
        AF.request(url, method: .get).responseDecodable(of: [UserModel].self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchUserByLogin(login: String ,completion: @escaping (Result<UserInformationModel, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.userEndpoint + login) else {
            completion(.failure(AFError.invalidURL(url: APIConstants.baseURL + APIConstants.usersEndpoint)))
            return
        }
        AF.request(url, method: .get).responseDecodable(of: UserInformationModel.self, decoder: CustomJSONDecoder()) { response in
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
                if let manager = NetworkReachabilityManager(), manager.isReachable {
                    completion(.failure(error))
                } else {
                    ErrorAlert.showErrorAlert(with: "error_no_internet_text".localized)
                    completion(.failure(error))
                }
            }
        }
    }
}
