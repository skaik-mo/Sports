//
//  SportShapeStack.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import SwiftUI
import Domain
import DesignSystem

struct SportShapeStack: View {

    let sportTypes: [SportType]
    let height: CGFloat?
    let font: Font
    let onTap: (SportType) -> Void

    var body: some View {
        LazyVStack(spacing: AppSpacing.lg) {
            ForEach(sportTypes, id: \.self) { sportType in
                SportsCard(
                    image: sportType.image,
                    title: sportType.title,
                    height: height,
                    font: font,
                ) {
                   onTap(sportType)
                }
            }
        }
    }
}
