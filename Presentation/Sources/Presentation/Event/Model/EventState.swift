//
//  EventState.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//


struct EventScreenData {
    var upcomingEvents: [EventUIModel]
    let latestEvents: [EventUIModel]
    let teams: [TeamUIModel]
}

public struct EventState {
    var eventsState: ViewState<EventScreenData> = .loading
    var isFavorite: Bool = false
}
