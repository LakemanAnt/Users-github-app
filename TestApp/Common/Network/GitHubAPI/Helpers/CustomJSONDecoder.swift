//
//  CustomJSONDecoder.swift
//  TestApp
//
//  Created by Anton on 01.02.2023.
//

import Foundation

public class CustomJSONDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()

    override public init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
