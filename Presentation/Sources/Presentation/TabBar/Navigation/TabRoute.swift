//
//  Tab.swift
//  Presentation
//
//  Created by Mohammed Skaik on 22/07/2026.
//

import DesignSystem

enum TabRoute: Hashable, CaseIterable {
    case home
    case favorite

    var title: String {
        switch self {
        case .home: return L10n.Tab.home
        case .favorite: return L10n.Tab.favorite
        }
    }

    var icon: String {
        switch self {
        case .home: return AppIcons.houseSystem
        case .favorite: return AppIcons.starSystem
        }
    }
}
