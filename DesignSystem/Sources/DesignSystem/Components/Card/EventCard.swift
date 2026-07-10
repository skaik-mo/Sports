//
//  EventCard.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import SwiftUI

public struct EventCard<PlaceholderView: View, FailureView: View>: View {
    private let date: String
    private let vs: String
    private let score: String
    private let time: String
    private let homeTeamName: String
    private let homeTeamLogo: String
    private let awayTeamName: String
    private let awayTeamLogo: String
    private let placeholderView: PlaceholderView
    private let failureView: FailureView

    public init(
        date: String,
        vs: String,
        score: String,
        time: String,
        homeTeamName: String,
        homeTeamLogo: String,
        awayTeamName: String,
        awayTeamLogo: String,
        @ViewBuilder placeholderView: () -> PlaceholderView,
        @ViewBuilder failureView: () -> FailureView,
    ) {
        self.date = date
        self.vs = vs
        self.score = score
        self.time = time
        self.homeTeamName = homeTeamName
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamName = awayTeamName
        self.awayTeamLogo = awayTeamLogo
        self.placeholderView = placeholderView()
        self.failureView = failureView()
    }

    public var body: some View {
        VStack(spacing: AppSpacing.md) {
            Text(date)
                .font(AppFonts.regular16)
                .foregroundStyle(AppColors.secondaryText)

            HStack {
                TeamCard(
                    logo: homeTeamLogo,
                    name: homeTeamName,
                    placeholderView: { placeholderView },
                    failureView: { failureView }
                )
                .frame(width: 115, height: 150)
                Spacer()
                VStack(spacing: AppSpacing.xs) {
                    Text(vs)
                        .font(AppFonts.medium26)
                        .foregroundStyle(AppColors.primaryText)
                    if !score.isEmpty || score != "-" {
                        Text(score)
                            .font(AppFonts.medium20)
                            .foregroundStyle(AppColors.primaryText)
                    }
                }
                Spacer()
                TeamCard(
                    logo: awayTeamLogo,
                    name: awayTeamName,
                    placeholderView: { placeholderView },
                    failureView: { failureView }
                )
                .frame(width: 115, height: 150)
            }

            Text(time)
                .font(AppFonts.regular16)
                .foregroundStyle(AppColors.secondaryText)
        }
        .padding(AppSpacing.lg)
        .background(AppColors.secondaryBackground)
        .cornerRadius(AppRadius.large)
        .shadow(color: AppColors.shadow, radius: AppRadius.xSmall, y: 2)
    }
}

#Preview {
    EventCard(
        date: "2024-11-10",
        vs: "VS",
        score: "",
        time: "20:00",
        homeTeamName: "Athletic Club de Bilbao",
        homeTeamLogo: "https://media.api-sports.io/football/teams/531.png",
        awayTeamName: "Real Sociedad de Fútbol Sociedad de Fútbol",
        awayTeamLogo: "https://media.api-sports.io/football/teams/548.png",
        placeholderView: { ProgressView() },
        failureView: {
            Image(systemName: "shield.slash")
                .foregroundStyle(.gray)
        }
    )
    .padding()
}
