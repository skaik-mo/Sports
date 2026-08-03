//
//  ParticipantCache.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//

import SwiftUI
import SwiftData

@Model
final class ParticipantCache {
    @Attribute(.unique)
    var uniqueKey: String

    var id: Int
    var name: String?
    var logo: String?
    var leagueId: Int
    var type: String

    init(
        id: Int,
        name: String?,
        logo: String?,
        leagueId: Int,
        type: ParticipantType
    ) {
        self.uniqueKey = "\(leagueId)-\(type.rawValue)-\(id)"
        self.id = id
        self.name = name
        self.logo = logo
        self.leagueId = leagueId
        self.type = type.rawValue
    }
}
