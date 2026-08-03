//
//  EventDto.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

struct EventDto: Decodable, Sendable {
    let event_key: Int?
    let event_date_start: String?
    let event_date: String?
    let event_time: String?
    let event_final_result: String?

    let home_team_key: Int?
    let event_home_team: String?
    let home_team_logo: String?

    let away_team_key: Int?
    let event_away_team: String?
    let away_team_logo: String?

    let first_player_key: Int?
    let event_first_player: String?
    let event_first_player_logo: String?

    let second_player_key: Int?
    let event_second_player: String?
    let event_second_player_logo: String?
}
