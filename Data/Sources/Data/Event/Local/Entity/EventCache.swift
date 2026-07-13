//
//  EventCache.swift
//  Data
//
//  Created by Mohammed Skaik on 13/07/2026.
//

import SwiftData
import Foundation

@Model 
final class EventCache {
    @Attribute(.unique)
    var id: Int
    var date: Date?
    var finalResult: String?
    var status: String?
    var leagueId: Int
    var section: String

    var homeTeamKey: Int
    var homeTeamName: String?
    var homeTeamLogo: String?

    var awayTeamKey: Int
    var awayTeamName: String?
    var awayTeamLogo: String?

    init(
        id: Int,
        date: Date?,
        finalResult: String?,
        status: String?,
        leagueId: Int,
        section: String,
        homeTeamKey: Int,
        homeTeamName: String?,
        homeTeamLogo: String?,
        awayTeamKey: Int,
        awayTeamName: String?,
        awayTeamLogo: String?
    ) {
        self.id = id
        self.date = date
        self.finalResult = finalResult
        self.status = status
        self.leagueId = leagueId
        self.section = section
        self.homeTeamKey = homeTeamKey
        self.homeTeamName = homeTeamName
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamKey = awayTeamKey
        self.awayTeamName = awayTeamName
        self.awayTeamLogo = awayTeamLogo
    }
}
