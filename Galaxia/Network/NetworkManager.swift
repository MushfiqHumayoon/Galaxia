//
//  NetworkManager.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

enum NetworkError: Error {
    case invalidUrl, noData
}

import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchApiData() -> AnyPublisher<[ApiResult], Error> {
        guard let url = URL(string: "http://test.lascade.com/api/test/list") else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map(\.result)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
