//
//  EventMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain
import Foundation

extension EventDto {

    func toDomain(sportType: SportType) throws -> Event {
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
            teams: try makeMatchTeams(sportType: sportType)
        )
    }

    func toCache(leagueId: Int, section: EventSection, sportType: SportType) throws -> EventCache {
        let formatter = DateFormatter.dateFormat(format: "yyyy-MM-dd HH:mm")

        guard let event_date,
              let event_time,
              let eventDateTime = formatter.date(
                from: "\(event_date) \(event_time)"
              )
        else {
            throw DomainException.invalidDate
        }

        let teams = try makeMatchTeams(sportType: sportType)
        return EventCache(
            id: self.event_key,
            date: eventDateTime,
            finalResult: self.event_final_result,
            status: self.event_status,
            leagueId: leagueId,
            section: section.rawValue,
            homeTeamKey: teams.homeTeam.id,
            homeTeamName: teams.homeTeam.name,
            homeTeamLogo: teams.homeTeam.logoUrl,
            awayTeamKey: teams.awayTeam.id,
            awayTeamName: teams.awayTeam.name,
            awayTeamLogo: teams.awayTeam.logoUrl,
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

private extension EventDto {

    func makeMatchTeams(sportType: SportType) throws -> MatchTeams {
        switch sportType {
        case .football, .basketball, .cricket:
            guard let homeId = home_team_key,
                  let awayId = away_team_key
            else {
                throw DomainException.missingTeams
            }

            return MatchTeams(
                homeTeam: Team(
                    id: homeId,
                    name: event_home_team,
                    logoUrl: home_team_logo
                ),
                awayTeam: Team(
                    id: awayId,
                    name: event_away_team,
                    logoUrl: away_team_logo
                )
            )


        case .tennis:
            guard let firstId = first_player_key,
                  let secondId = second_player_key
            else {
                throw DomainException.missingPlayers
            }

            return MatchTeams(
                homeTeam: Team(
                    id: firstId,
                    name: event_first_player,
                    logoUrl: event_first_player_logo
                ),
                awayTeam: Team(
                    id: secondId,
                    name: event_second_player,
                    logoUrl: event_second_player_logo
                )
            )
        }
    }
}
