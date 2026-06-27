//
//  MatchTeams.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public struct MatchTeams {
    public let homeTeam: Team
    public let awayTeam: Team

    public init(homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}
