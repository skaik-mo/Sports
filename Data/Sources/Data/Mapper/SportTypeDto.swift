//
//  SportTypeDto.swift
//  Data
//
//  Created by Mohammed Skaik on 17/06/2026.
//

import Domain

enum SportTypeDto: String {
    case football
    case cricket
    case basketball
    case tennis

    var path: String {
        switch self {
        case .football: "football"
        case .basketball: "basketball"
        case .cricket: "cricket"
        case .tennis: "tennis"
        }
    }

    static func sportMapper(from sport: SportType) -> SportTypeDto {
        switch sport {
        case .football: .football
        case .basketball: .basketball
        case .cricket: .cricket
        case .tennis: .tennis
        }
    }
}
