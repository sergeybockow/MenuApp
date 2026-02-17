//
//  MainView.swift
//  Menu
//
//  Created by manolo on 12/20/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @StateObject private var service = ContentServiceCombine()
    
    var body: some View {
        NavigationView {
            List(service.items) { item in
                MenuRow(item: item)
            }
            .listStyle(.plain)
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear {
                service.getMenuItemData()
            }
        }
    }
}

struct MenuRow: View {
    let item: ContentItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                if let title = item.title, !title.isEmpty {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer(minLength: 8)
            
            if let urlString = item.imageUrl, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    default:
                        Color(UIColor.systemGray6)
                    }
                }
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .clipped()
            } else {
                // Если картинки нет в данных, можно оставить пустое место 80x80
                // или убрать этот блок. В UIKit мы скрывали, поэтому тут просто ничего не пишем.
                // Но чтобы текст не лип к краю, Spacer выше всё удержит.
            }
        }
        .padding(.vertical, 8)
    }
}
