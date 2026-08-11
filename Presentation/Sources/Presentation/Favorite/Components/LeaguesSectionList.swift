//
//  LeaguesSectionList.swift
//  Presentation
//
//  Created by Mohammed Skaik on 15/07/2026.
//


import SwiftUI
import DesignSystem
import Domain

struct LeaguesSectionList: View {
    let sections: [LeagueSection]
    let onTap: (LeagueUIModel) -> Void
    let onRemove: (LeagueUIModel) -> Void

    var body: some View {
        List {
            ForEach(sections) { section in
                Section {
                    ForEach(section.leagues) { league in
                        LeagueCard(
                            logo: league.leagueLogo,
                            leagueName: league.leagueName,
                            countryName: league.countryName
                        )
                        .listRowBackground(AppColors.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(
                            EdgeInsets(
                                top: AppSpacing.md,
                                leading: AppSpacing.xl,
                                bottom: AppSpacing.md,
                                trailing: AppSpacing.xl
                            )
                        )
                        .onTapGesture {
                            onTap(league)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                onRemove(league)
                            } label: {
                                Label(
                                    L10n.Favorite.remove,
                                    systemImage: AppIcons.trashSystem
                                )
                            }
                        }
                    }
                } header: {
                    SectionHeaderView(title: section.sportType.title)
                }
            }
            Color.clear
                    .frame(height: 80)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(AppColors.clear)
                    .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .listSectionSpacing(0)
        .scrollIndicators(.hidden)
    }
}
