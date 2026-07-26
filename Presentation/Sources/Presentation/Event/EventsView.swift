//
//  EventView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import SwiftUI
import DesignSystem

public struct EventsView: View {
    @State private var viewModel: EventsViewModel
    private var participantsTitle: String {
        viewModel.isTennisSport() ? L10n.Events.players : L10n.Events.teams
    }

    public init(viewModel: EventsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Group {
            switch viewModel.state.eventsState {
            case .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .failure(let message):
                ErrorView(
                    message: message,
                    onRetry: {
                        viewModel.getData()
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)


            case .empty:
                refreshableScroll {
                    EmptyStateView(
                        message: L10n.Events.empty,
                        iconSystem: AppIcons.basketballSystem
                    )
                    .containerRelativeFrame([.horizontal, .vertical])
                }

            case .success(let data):
                refreshableScroll {
                    SectionHeaderView(title: L10n.Events.upcomingMatches)
                    HorizontalCarousel(items: data.upcomingEvents) { event in
                        eventCard(for: event)
                            .padding(.top, AppSpacing.xs)
                            .padding(.bottom, AppSpacing.sm)
                    }

                    SectionHeaderView(title: L10n.Events.latest_matches)
                    LazyVStack(spacing: AppSpacing.lg) {
                        ForEach(data.latestEvents) { event in
                            eventCard(for: event)
                        }
                    }
                    .padding(.top, AppSpacing.xs)

                    SectionHeaderView(title: participantsTitle)
                    HorizontalCarousel(items: data.teams) { team in
                        TeamCard(logo: team.logo, name: team.name) {
                            placeholderLogoView()
                        } failureView: {
                            placeholderLogoView()
                        }
                        .padding(AppSpacing.lg)
                        .background(AppColors.secondaryBackground)
                        .cornerRadius(AppRadius.large)
                        .shadow(
                            color: AppColors.shadow,
                            radius: AppRadius.xSmall,
                            y: 2
                        )
                        .padding(.top, AppSpacing.xs)
                        .padding(.bottom, AppSpacing.sm)
                    }
                }
            }
        }
        .navigationTitle(L10n.Events.title)
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(
            tintColor: .green,
            backgroundColor: AppColors.backButtonBackground,
            backgroundShadowColor: AppColors.foreground.opacity(0.3)
        )
        .background(AppColors.background)
        .task {
            viewModel.getData()
        }
    }
}


private extension EventsView {
    @ViewBuilder
    func refreshableScroll<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ScrollView(.vertical) {
            content()
        }
        .refreshable {
            viewModel.getData()
        }
    }

    @ViewBuilder
    func placeholderLogoView() -> some View {
        Image(AppIcons.logo)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
    }

    @ViewBuilder
    func eventCard(for event: EventUIModel) -> some View {
        EventCard(
            date: event.date,
            vs: L10n.Events.vs,
            score: event.finalResult,
            time: event.time,
            homeTeamName: event.homeTeams.name,
            homeTeamLogo: event.homeTeams.logo,
            awayTeamName: event.awayTeams.name,
            awayTeamLogo: event.awayTeams.logo
        ) {
            placeholderLogoView()
        } failureView: {
            placeholderLogoView()
        }
        .frame(
            width: UIScreen.main.bounds.size
                .width - (AppSpacing.lg * 2)
        )
    }
}

