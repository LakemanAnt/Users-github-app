//
//  APIConstants.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

struct APIConstants {
    static let baseURL = "https://api.github.com"
    static let countOfElementsForOneLoad = 20
    
    //MARK: Endpoints
    static let usersEndpoint = "/users?&per_page=\(countOfElementsForOneLoad)&since="
    static let userEndpoint = "/users/"
}
