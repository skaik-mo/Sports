//
//  EventDto.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

struct EventDto: Decodable {
    let event_key: Int
    let event_date: String?
    let event_time: String?
    let event_final_result: String?
    let event_status: String?

    let home_team_key: Int
    let event_home_team: String?
    let home_team_logo: String?

    let away_team_key: Int
    let event_away_team: String?
    let away_team_logo: String?
}
