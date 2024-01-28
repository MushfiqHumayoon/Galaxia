//
//  ApiResponse.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import Foundation

public struct ApiResponse: Codable {
    let status: Bool
    let message: String
    let error: String?
    let result: [ApiResult]
}

struct ApiResult: Codable {
    let title: String?
    let description: String?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case title, description
        case imageUrl = "image-url"
    }
}
