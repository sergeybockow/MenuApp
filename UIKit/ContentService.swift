//
//  ContentService.swift
//  Menu
//
//  Created by Alice Hyun on 11/10/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import Foundation

final class ContentService {
    private let session: FakeNetworkSession
    
    init(session: FakeNetworkSession) {
        self.session = session
    }
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /// fetches data to retrieve item content
    func getItemData(completion: @escaping ([ContentItem]) -> Void) {
        // pretend this is a real network request, but you
        // can assume there will always be data and no error
        session.networkTask { [weak self] data in // background
            guard let self else { return }
            print(String(data: data, encoding: .utf8)!)
            guard let model = try? self.jsonDecoder.decode(ContentItems.self, from: data) else {
                return
            }
            completion(model.contentItems)
        }
    }
}
