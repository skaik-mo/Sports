//
//  PlayerDto.swift
//  Data
//
//  Created by Mohammed Skaik on 03/08/2026.
//


struct PlayerDto: Decodable, Sendable {
    let player_key: Int?
    let player_name: String?
    let player_logo: String?
}