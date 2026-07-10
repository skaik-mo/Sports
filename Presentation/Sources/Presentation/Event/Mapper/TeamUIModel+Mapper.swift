//
//  TeamUI+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

import Domain

extension Team {
    func toUIModel() -> TeamUIModel {
        TeamUIModel(
            id: id,
            name: name.orEmpty(),
            logo: logoUrl.orEmpty()
        )
    }
}

extension Array where Element == Team {
    func toUIModels() -> [TeamUIModel] {
        map { $0.toUIModel() }
    }
}
