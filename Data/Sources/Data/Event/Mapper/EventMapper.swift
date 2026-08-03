//
//  EventMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain
import Foundation

extension EventDto {

    func toDomain(sportType: SportType) -> Event? {
        guard let event_key else { return nil }

        let firstParticipant: Participant
        let secondParticipant: Participant

        switch sportType {
        case .football, .basketball, .cricket:
            guard let homeKey = home_team_key, let awayKey = away_team_key else {
                return nil
            }
            firstParticipant = Participant(
                id: homeKey,
                name: event_home_team,
                logoUrl: home_team_logo
            )
            secondParticipant = Participant(
                id: awayKey,
                name: event_away_team,
                logoUrl: away_team_logo
            )

        case .tennis:
            guard let firstKey = first_player_key, let secondKey = second_player_key else {
                return nil
            }
            firstParticipant = Participant(
                id: firstKey,
                name: event_first_player,
                logoUrl: event_first_player_logo
            )
            secondParticipant = Participant(
                id: secondKey,
                name: event_second_player,
                logoUrl: event_second_player_logo
            )
        }

        let rawDate = sportType == .cricket ? event_date_start : event_date
        let combinedDateString = "\(rawDate ?? "") \(event_time ?? "")"
        let parsedDate = DateFormatter
            .dateFormat(format: "yyyy-MM-dd HH:mm")
            .date(
                from: combinedDateString
            )

        return Event(
            id: event_key,
            date: parsedDate,
            finalResult: event_final_result,
            firstParticipant: firstParticipant,
            secondParticipant: secondParticipant
        )
    }

}


extension Event {
    func toCache(leagueId: Int, section: EventSection) -> EventCache {
        EventCache(
            id: id,
            date: date,
            finalResult: finalResult,
            leagueId: leagueId,
            section: section.rawValue,
            firstParticipantKey: firstParticipant.id,
            firstParticipantName: firstParticipant.name,
            firstParticipantLogo: firstParticipant.logoUrl,
            secondParticipantKey: secondParticipant.id,
            secondParticipantName: secondParticipant.name,
            secondParticipantLogo: secondParticipant.logoUrl
        )
    }
}

extension EventCache {
    func toDomain() -> Event {
        Event(
            id: id,
            date: date,
            finalResult: finalResult,
            firstParticipant: Participant(
                id: firstParticipantKey,
                name: firstParticipantName,
                logoUrl: firstParticipantLogo
            ),
            secondParticipant: Participant(
                id: secondParticipantKey,
                name: secondParticipantName,
                logoUrl: secondParticipantLogo
            )
        )
    }
}
