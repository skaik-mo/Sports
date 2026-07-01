//
//  SportType+UI.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import SwiftUI
import Domain
import DesignSystem

extension SportType {
    var title: String {
        switch self {
        case .football: return L10n.Home.footballTitle
        case .basketball: return L10n.Home.basketballTitle
        case .cricket: return L10n.Home.cricketTitle
        case .tennis: return L10n.Home.tennisTitle
        }
    }

    var image: Image {
        switch self {
        case .football: return AppImages.football
        case .basketball: return AppImages.basketball
        case .cricket: return AppImages.cricket
        case .tennis: return AppImages.tennis
        }
    }
}
