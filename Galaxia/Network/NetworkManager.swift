//
//  NetworkManager.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

//class NetworkManager {
//    static let shared = NetworkManager()
//    private init() {}
//
//    func fetchApiData(completion: @escaping (Result<[ApiResult], Error>) -> Void) {
//        guard let url = URL(string: "http://test.lascade.com/api/test/list") else {
//            completion(.failure(NetworkError.invalidUrl))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NetworkError.noData))
//                return
//            }
//
//            do {
//                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
//                completion(.success(apiResponse.result))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//}
//
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
