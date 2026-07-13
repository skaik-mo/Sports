//
//  EventUI+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

extension Event { 
    func toUIModel() -> EventUIModel? {
        guard let homeTeam = teams?.homeTeam,
              let awayTeam = teams?.awayTeam,
              let date else {
            return nil
        }
        let dateFormatted = date.ddMMyyyy
        let timeFormatted = date.timeFormatted
        return EventUIModel(
            id: id,
            date: dateFormatted,
            time: timeFormatted,
            finalResult: finalResult.orEmpty(),
            homeTeams: homeTeam.toUIModel(),
            awayTeams: awayTeam.toUIModel()
        )
    }
}

extension Array where Element == Event {
    func toUIModel() -> [EventUIModel] {
        compactMap { $0.toUIModel() }
    }
}
