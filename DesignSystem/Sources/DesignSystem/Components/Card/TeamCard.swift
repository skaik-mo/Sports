//
//  TeamCard.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import SwiftUI

public struct TeamCard<PlaceholderView: View, FailureView: View>: View {
    private let logo: String
    private let name: String
    private let placeholderView: PlaceholderView
    private let failureView: FailureView

    public init(
        logo: String,
        name: String,
        @ViewBuilder placeholderView: () -> PlaceholderView,
        @ViewBuilder failureView: () -> FailureView,
    ) {
        self.logo = logo
        self.name = name
        self.placeholderView = placeholderView()
        self.failureView = failureView()
    }

    public var body: some View {
        VStack(spacing: AppSpacing.xs) {
            RemoteImage(
                url: URL(string: logo),
                placeholderView: { placeholderView },
                failureView:{ failureView }
            )
            .frame(width: 100, height: 100)
            Text(name)
                .font(AppFonts.medium16)
                .foregroundStyle(AppColors.primaryText)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}

#Preview {
    TeamCard(
        logo: "https://media.api-sports.io/football/teams/541.png",
        name: "Real Madrid",
        placeholderView: {
            ProgressView()
        },
        failureView: {
            Image(systemName: "shield.slash")
                .foregroundStyle(.gray)
        }
    )
}
