//
//  EventUI+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

extension Event { 
    func toUIModel() -> EventUIModel? {
        guard let date else {
            return nil
        }
        let dateFormatted = date.ddMMyyyy
        let timeFormatted = date.timeFormatted
        return EventUIModel(
            id: id,
            date: dateFormatted,
            time: timeFormatted,
            finalResult: finalResult.orEmpty(),
            firstParticipant: firstParticipant.toUIModel(),
            secondParticipant: secondParticipant.toUIModel()
        )
    }
}

extension Array where Element == Event {
    func toUIModel() -> [EventUIModel] {
        compactMap { $0.toUIModel() }
    }
}
