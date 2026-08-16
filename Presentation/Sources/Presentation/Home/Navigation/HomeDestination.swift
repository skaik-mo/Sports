//
//  HomeDestination.swift
//  Presentation
//
//  Created by Mohammed Skaik on 16/08/2026.
//

import Domain

enum HomeDestination: Hashable {
    case leagues(sportType: SportType)
    case events(parameters: EventsParameters)
}
