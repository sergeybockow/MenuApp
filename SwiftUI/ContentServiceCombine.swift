//
//  ContentServiceCombine.swift
//  Menu
//
//  Created by manolo on 3/28/22.
//  Copyright © 2022 DoorDash, Inc. All rights reserved.
//

import Combine
import Foundation

class ContentServiceCombine: ObservableObject {
    @Published var items: [ContentItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let session = FakeNetworkSession()
    
    private let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
    
    /// fetches data to retrieve item content
    func getMenuItemData() {
        // pretend this is a real network request, but you
        // can assume there will always be data and no error
        session
            .networkCall
            .decode(type: ContentItems.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Ошибка загрузки: \(error)")
                    }
                },
                receiveValue: { [weak self] response in
                    self?.items = response.contentItems
                }
            )
            .store(in: &cancellables)
    }
}
