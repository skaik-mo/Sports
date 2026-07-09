//
//  EventState.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//


struct EventScreenData {
    var upcomingEvents: [EventUI]
    let latestEvents: [EventUI]
    let teams: [TeamUI]
}

public struct EventState {
    var eventsState: ViewState<EventScreenData> = .loading
}
