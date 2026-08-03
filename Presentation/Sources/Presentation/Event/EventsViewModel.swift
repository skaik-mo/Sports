//
//  EventViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

public final class EventsViewModel: BaseViewModel<EventState> {
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    private let isFavoriteUseCase: IsFavoriteUseCase
    private let getUpcomingEventsUseCase: GetUpcomingEventsUseCase
    private let getLatestEventsUseCase: GetLatestEventsUseCase
    private let getTeamsUseCase: GetTeamsUseCase
    private let getPlayersUseCase: GetPlayersUseCase
    private let sportType: SportType
    private let leagueId: Int

    private enum TaskID: String {
        case events
        case toggleFavorite
        case isFavorite
    }

    public init(
        toggleFavoriteUseCase: ToggleFavoriteUseCase,
        isFavoriteUseCase: IsFavoriteUseCase,
        getUpcomingEventsUseCase: GetUpcomingEventsUseCase,
        getLatestEventsUseCase: GetLatestEventsUseCase,
        getTeamsUseCase: GetTeamsUseCase,
        getPlayersUseCase: GetPlayersUseCase,
        sportType: SportType,
        leagueId: Int
    ) {
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
        self.getUpcomingEventsUseCase = getUpcomingEventsUseCase
        self.getLatestEventsUseCase = getLatestEventsUseCase
        self.getTeamsUseCase = getTeamsUseCase
        self.getPlayersUseCase = getPlayersUseCase
        self.sportType = sportType
        self.leagueId = leagueId
        super.init(initialState: EventState())
    }

}

extension EventsViewModel {

    func getEvents(withLoading: Bool = true) {
        if withLoading { setLoading() }

        tryToExecute(
            id: TaskID.events.rawValue,
            onFailure: handleFailure(),
            onSuccess: getDataSuccess()
        ) { [weak self] in
            guard let self else { throw DomainException.unknown }

            async let upcoming = self.getUpcomingEventsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModel()
            async let latest = self.getLatestEventsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModel()
            async let participants = self.getParticipants()

            let (upcomingResult, latestResult, participantsResult) = try await (
                upcoming,
                latest,
                participants
            )

            return EventScreenData(
                upcomingEvents: upcomingResult,
                latestEvents: latestResult,
                participants: participantsResult
            )
        }
    }

    private func getParticipants() async throws -> [ParticipantUIModel] {
        if sportType == .tennis {
            return try await getPlayersUseCase
                .execute(
                    sportType: sportType,
                    leagueId: leagueId
                )
                .toUIModels()
        } else {
            return try await getTeamsUseCase
                .execute(
                    sportType: sportType,
                    leagueId: leagueId
                )
                .toUIModels()
        }
    }

    private func setLoading() {
        updateState(
            key: \.eventsState,
            to: .loading
        )
    }

    private func getDataSuccess() -> (EventScreenData) -> Void {
        return { [weak self] (data: EventScreenData) in
            let isEmpty = data.upcomingEvents.isEmpty && data.latestEvents.isEmpty && data.participants.isEmpty
            self?.updateState(
                key: \.eventsState,
                to: isEmpty ? .empty : .success(data)
            )
        }
    }

}

extension EventsViewModel {

    func setFavorite() {
        let previousValue = state.isFavorite
        updateState(key: \.isFavorite, to: !previousValue)

        tryToExecute(
            id: TaskID.toggleFavorite.rawValue,
            onFailure: handleFavoriteFailure(previousValue: previousValue),
        ) { [weak self] in
            guard let self else { throw DomainException.unknown }
            return try await toggleFavoriteUseCase
                .execute(leagueId: self.leagueId)
        }

    }

    private func handleFavoriteFailure(previousValue: Bool) -> (DomainException) -> Void {
        return { [weak self] _ in
            self?.updateState(key: \.isFavorite, to: previousValue)
        }
    }
}

extension EventsViewModel {

    func getFavoriteStatus() {
        tryToExecute(
            id: TaskID.isFavorite.rawValue,
            onFailure: handleFailure(),
            onSuccess: getFavoriteStatusSuccess()
        ) { [weak self] in
            guard let self else { throw DomainException.unknown }
            return try await isFavoriteUseCase.execute(leagueId: self.leagueId)
        }

    }

    private func getFavoriteStatusSuccess() -> (Bool) -> Void {
        return { [weak self] status in
            self?.updateState(key: \.isFavorite, to: status)
        }
    }
}


private extension EventsViewModel {
    func handleFailure() -> (Error) -> Void {
        return { [weak self] error in
            self?.updateState(
                key: \.eventsState,
                to: .failure(error.localizedDescription)
            )
        }
    }
}

extension EventsViewModel {

    func isTennisSport() -> Bool {
        sportType == SportType.tennis
    }
}
