//
//  SportsCard.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import SwiftUI

public struct SportsCard: View {
    let image: Image
    let title: String
    let height: CGFloat?
    let font: Font
    let padding: CGFloat
    let onTap: () -> Void

    public init(
        image: Image,
        title: String,
        height: CGFloat? = nil,
        font: Font,
        padding: CGFloat,
        onTap: @escaping () -> Void
    ) {
        self.image = image
        self.title = title
        self.height = height
        self.font = font
        self.padding = padding
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            LazyVStack(spacing: AppSpacing.sm) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                Text(title)
                    .font(font)
                    .foregroundStyle(AppColors.primaryText)
            }
            .padding(padding)
            .background(AppColors.secondaryBackground)
            .radius(radius: AppRadius.large)
            .shadow(
                color: AppColors.shadow,
                radius: AppRadius.small,
                x: 0,
                y: 2
            )
        }
    }
}

#Preview {
    SportsCard(
        image: AppImages.basketball,
        title: "Basketball",
        height: nil,
        font: .headline,
        padding: 12
    ) {
        print("SportsCard tapped")
    }
    .padding()
}

