//
//  HomeRoute.swift
//  Presentation
//
//  Created by Mohammed Skaik on 19/07/2026.
//

import Domain

enum HomeRoute: Hashable {
    case leagues(sportType: SportType)
    case events(parameters: EventsParameters)
}
