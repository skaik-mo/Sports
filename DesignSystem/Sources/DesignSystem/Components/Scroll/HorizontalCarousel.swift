//
//  Product.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import SwiftUI

public struct HorizontalCarousel<T: Identifiable, Content: View>: View {
    private let items: [T]
    @ViewBuilder private let content: (_ item: T) -> Content

    public init(
        items: [T],
        content: @escaping (_ item: T) -> Content
    ) {
        self.items = items
        self.content = content
    }

    public var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            ScrollView(.horizontal) {
                LazyHStack(spacing: AppSpacing.lg) {
                    ForEach(items) { item in
                        content(item)
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.never)
        }
    }
}

private struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let systemImage: String
}

#Preview {
    let products: [Product] = [
        Product(
            name: "Wireless headphones",
            price: "$89",
            systemImage: "headphones"
        ),
        Product(
            name: "Mechanical keyboard",
            price: "$120",
            systemImage: "keyboard"
        ),
        Product(
            name: "Desk lamp",
            price: "$34",
            systemImage: "lamp.desk"
        ),
    ]

    HorizontalCarousel(
        items: products
    ) { item in
        HStack {
            Image(systemName: item.systemImage)
                .frame(width: 32, height: 32)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.price)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width - 30, height: 100)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
