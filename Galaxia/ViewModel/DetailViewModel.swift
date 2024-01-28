//
//  DetailViewModel.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import Foundation
import Combine

class DetailViewModel {
    //MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    @Published var planetList = [ApiResult]()
    var isLoading = false
    //MARK: - Init Method
    init() { loadData() }
    //MARK: - Fetch Data from API
    private func loadData() {
        isLoading = true
        NetworkManager.shared.fetchApiData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { apiResults in
                self.planetList = apiResults // setting the data into an array
            })
            .store(in: &cancellables)
        }
}
