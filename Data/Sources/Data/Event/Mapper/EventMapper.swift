//
//  EventMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain
import Foundation

extension EventDto {

    func toDomain() throws -> Event {
        let formatter = DateFormatter.dateFormat(format: "yyyy-MM-dd HH:mm")

        guard let event_date,
              let event_time,
              let eventDateTime = formatter.date(
                from: "\(event_date) \(event_time)"
              )
        else {
            throw DomainException.invalidDate
        }

        return Event(
            id: self.event_key,
            date: eventDateTime,
            finalResult: self.event_final_result,
            status: self.event_status,
            teams: MatchTeams(
                homeTeam: Team(
                    id: self.home_team_key,
                    name: self.event_home_team,
                    logoUrl: self.home_team_logo
                ),
                awayTeam: Team(
                    id: self.away_team_key,
                    name: self.event_away_team,
                    logoUrl: self.away_team_logo
                )
            )
        )
    }


    func toCache(leagueId: Int, section: EventSection) throws -> EventCache {
        let formatter = DateFormatter.dateFormat(format: "yyyy-MM-dd HH:mm")

        guard let event_date,
              let event_time,
              let eventDateTime = formatter.date(
                from: "\(event_date) \(event_time)"
              )
        else {
            throw DomainException.invalidDate
        }

        return EventCache(
            id: self.event_key,
            date: eventDateTime,
            finalResult: self.event_final_result,
            status: self.event_status,
            leagueId: leagueId,
            section: section.rawValue,
            homeTeamKey: self.home_team_key,
            homeTeamName: self.event_home_team,
            homeTeamLogo: self.home_team_logo,
            awayTeamKey: self.away_team_key,
            awayTeamName: self.event_away_team,
            awayTeamLogo: self.away_team_logo,
        )
    }
}

extension EventCache {
    func toDomain() -> Event {
        Event(
            id: self.id,
            date: self.date,
            finalResult: self.finalResult,
            status: self.status,
            teams: MatchTeams(
                homeTeam: Team(
                    id: self.homeTeamKey,
                    name: self.homeTeamName,
                    logoUrl: self.homeTeamLogo
                ),
                awayTeam: Team(
                    id: self.awayTeamKey,
                    name: self.awayTeamName,
                    logoUrl: self.awayTeamLogo
                )
            )
        )
    }
}
