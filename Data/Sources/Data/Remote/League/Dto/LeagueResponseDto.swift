//
//  LeagueResponseDto.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

struct LeagueResponseDto: Decodable {
    let success: Int
    let result: [LeagueDto]
}
