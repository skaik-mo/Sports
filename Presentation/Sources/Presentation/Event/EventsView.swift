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
                        viewModel.getEvents()
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
                    if !data.upcomingEvents.isEmpty {
                        upcomingEventsSection(
                            upcomingEvents: data.upcomingEvents
                        )
                    }
                    if !data.latestEvents.isEmpty {
                        latestEventsSection(latestEvents: data.latestEvents)
                    }
                    if !data.participants.isEmpty {
                        participantsSection(participants: data.participants)
                    }
                }
            }
        }
        .navigationTitle(L10n.Events.title)
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(
            tintColor: AppColors.primary,
            backgroundColor: AppColors.backButtonBackground,
            backgroundShadowColor: AppColors.foreground.opacity(0.3)
        )
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                FavoriteButton(isFavorite: viewModel.state.isFavorite) {
                    viewModel.setFavorite()
                }
            }
            .hideSharedBackgroundIfAvailable()
        }
        .background(AppColors.background)
        .task {
            viewModel.getEvents()
            viewModel.getFavoriteStatus()
        }
        .onDisappear {
            viewModel.cancelAllTasks()
        }
    }
}


private extension EventsView {

    @ViewBuilder
    func upcomingEventsSection(upcomingEvents: [EventUIModel]) -> some View {
        SectionHeaderView(title: L10n.Events.upcomingMatches)
        HorizontalCarousel(items: upcomingEvents) { event in
            eventCard(for: event)
                .padding(.top, AppSpacing.xs)
                .padding(.bottom, AppSpacing.sm)
        }
    }

    @ViewBuilder
    func latestEventsSection(latestEvents: [EventUIModel]) -> some View {
        SectionHeaderView(title: L10n.Events.latest_matches)
        LazyVStack(spacing: AppSpacing.lg) {
            ForEach(latestEvents) { event in
                eventCard(for: event)
            }
        }
        .padding(.top, AppSpacing.xs)
    }

    @ViewBuilder
    func participantsSection(participants: [ParticipantUIModel]) -> some View {
        SectionHeaderView(title: participantsTitle)
        HorizontalCarousel(items: participants) { participant in
            ParticipantCard(logo: participant.logo, name: participant.name) {
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


private extension EventsView {
    @ViewBuilder
    func refreshableScroll<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ScrollView(.vertical) {
            content()
        }
        .refreshable {
            viewModel.getEvents(withLoading: false)
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
            firstParticipantName: event.firstParticipant.name,
            firstParticipantLogo: event.firstParticipant.logo,
            secondParticipantName: event.secondParticipant.name,
            secondParticipantLogo: event.secondParticipant.logo
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

