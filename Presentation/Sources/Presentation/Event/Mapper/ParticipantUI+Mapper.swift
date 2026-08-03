//
//  ParticipantUI+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

extension Participant {
    func toUIModel() -> ParticipantUIModel {
        ParticipantUIModel(
            id: id,
            name: name.orEmpty(),
            logo: logoUrl.orEmpty()
        )
    }
}

extension Array where Element == Participant {
    func toUIModels() -> [ParticipantUIModel] {
        map { $0.toUIModel() }
    }
}
