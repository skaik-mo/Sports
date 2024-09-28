//
//  TabbedItems.swift
//  Sports
//
//  Created by Mohammed Skaik on 28/09/2024.
//


enum TabbedItems: CaseIterable {
    case home
    case favorite

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        }
    }

    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favorite:
            return "star"
        }
    }
}