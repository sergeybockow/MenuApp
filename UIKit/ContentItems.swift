//
//  ContentItems.swift
//  Menu
//
//  Created by Сергей Бочков on 22.12.2025.
//  Copyright © 2025 DoorDash, Inc. All rights reserved.
//

import Foundation

struct ContentItems: Decodable {
    let contentItems: [ContentItem]
}

struct ContentItem: Decodable, Identifiable {
    var id: String { title ?? description }
    let title: String?
    let imageUrl: String?
    let description: String
}
