//
//  EventViewModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

public final class EventsViewModel: BaseViewModel<EventState> {
    private let getUpcomingEventsUseCase: GetUpcomingEventsUseCase
    private let getLatestEventsUseCase: GetLatestEventsUseCase
    private let getTeamsUseCase: GetTeamsUseCase
    private let sportType: SportType
    private let leagueId: Int

    private enum TaskID: String {
        case events
    }

    public init(
        getUpcomingEventsUseCase: GetUpcomingEventsUseCase,
        getLatestEventsUseCase: GetLatestEventsUseCase,
        getTeamsUseCase: GetTeamsUseCase,
        sportType: SportType,
        leagueId: Int
    ) {
        self.getUpcomingEventsUseCase = getUpcomingEventsUseCase
        self.getLatestEventsUseCase = getLatestEventsUseCase
        self.getTeamsUseCase = getTeamsUseCase
        self.sportType = sportType
        self.leagueId = leagueId
        super.init(initialState: EventState())
    }

}


extension EventsViewModel {

    func getData(withLoading: Bool = true) {
        if withLoading { setLoading() }

        tryToExecute(
            id: TaskID.events.rawValue,
            onFailure: getDataFailure(),
            onSuccess: getDataSuccess()
        ) { [weak self] in
            guard let self else { throw DomainException.unknown }

            async let upcoming = self.getUpcomingEventsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModel()
            async let latest = self.getLatestEventsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModel()
            async let teams = self.getTeamsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModels()

            let (upcomingResult, latestResult, teamsResult) = try await (
                upcoming,
                latest,
                teams
            )
            return EventScreenData(
                upcomingEvents: upcomingResult,
                latestEvents: latestResult,
                teams: teamsResult
            )
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
            let isEmpty = data.upcomingEvents.isEmpty && data.latestEvents.isEmpty && data.teams.isEmpty
            self?.updateState(
                key: \.eventsState,
                to: isEmpty ? .empty : .success(data)
            )
        }
    }

    private func getDataFailure() -> (Error) -> Void {
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
