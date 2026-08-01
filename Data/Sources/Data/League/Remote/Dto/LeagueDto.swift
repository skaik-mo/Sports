//
//  LeagueDto.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Foundation

struct LeagueDto: Decodable {
    let league_key: Int
    let league_name: String?
    let league_logo: String?
    let country_key: Int?
    let country_name: String?
    let country_logo: String?
}
