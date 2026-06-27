//
//  APIErrorDto.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


struct APIErrorDto: Decodable {
    let error: String
    let result: [APIErrorResultDto]
}

struct APIErrorResultDto: Decodable {
    let param: String?
    let msg: String?
    let cod: Int?
}
