//
//  ResponseDto.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

struct ResponseDto<T: Decodable>: Decodable {
    let success: Int
    let result: [T]
}
