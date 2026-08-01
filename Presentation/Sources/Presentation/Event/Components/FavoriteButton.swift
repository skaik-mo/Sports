//
//  FavoriteButton.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/08/2026.
//

import SwiftUI
import DesignSystem

struct FavoriteButton: View {
    let isFavorite: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(
                systemName: isFavorite ? AppIcons.starFillSystem : AppIcons.starSystem
            )
            .foregroundStyle(.yellow)
        }
    }
}
