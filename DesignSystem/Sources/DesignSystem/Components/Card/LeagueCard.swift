//
//  LeagueCard.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 07/07/2026.
//


import SwiftUI

public struct LeagueCard: View {
    private let logo: String
    private let leagueName: String
    private let countryName: String

    public init(logo: String, leagueName: String, countryName: String) {
        self.logo = logo
        self.leagueName = leagueName
        self.countryName = countryName
    }

    public var body: some View {
        HStack(alignment: .center, spacing: AppSpacing.xl) {
            RemoteImage(
                url: URL(string: logo),
                placeholderView: {
                    Image(AppIcons.logo)
                        .resizable()
                },
                failureView: {
                    Image(AppIcons.logo)
                        .resizable()
                }
            )
            .frame(width: 70, height: 70)
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(leagueName)
                    .font(AppFonts.medium14)
                    .foregroundStyle(AppColors.primaryText)
                Text(countryName)
                    .font(AppFonts.regular14)
                    .foregroundStyle(AppColors.secondaryText)

            }
            Spacer()
        }
        .padding(AppSpacing.lg)
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

#Preview {
    LeagueCard(
        logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzntbsUOb7uDmuHy0ZAg0YO80nZaSHzyD3TRpvLtvXYw&s=10",
        leagueName: "leagueName",
        countryName: "countryName"
    )
    .padding(AppSpacing.lg)
}
