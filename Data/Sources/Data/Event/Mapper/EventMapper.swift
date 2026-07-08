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
}
