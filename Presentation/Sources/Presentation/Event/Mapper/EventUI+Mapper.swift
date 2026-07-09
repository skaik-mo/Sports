//
//  EventUI+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

extension Event {
    func toUIModel() -> EventUI? {
        guard let homeTeam = teams?.homeTeam, let awayTeam = teams?.awayTeam else {
            return nil
        }
        let dateFormatted = date?.formatted(
            .dateTime
                .year()
                .month(.twoDigits)
                .day()
        )
        let timeFormatted = date?.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .omitted))
                .minute()
        )
        return EventUI(
            id: id,
            date: dateFormatted.orEmpty(),
            time: timeFormatted.orEmpty(),
            finalResult: finalResult.orEmpty(),
            homeTeams: homeTeam.toUIModel(),
            awayTeams: awayTeam.toUIModel()
        )
    }
}

extension Array where Element == Event {
    func toUIModel() -> [EventUI] {
        compactMap { $0.toUIModel() }
    }
}
