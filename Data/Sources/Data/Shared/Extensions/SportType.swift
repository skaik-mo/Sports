//
//  SportType.swift
//  Data
//
//  Created by Mohammed Skaik on 29/06/2026.
//

import Domain

extension SportType {
    var path: String {
        switch self {
        case .football: "football"
        case .basketball: "basketball"
        case .cricket: "cricket"
        case .tennis: "tennis"
        }
    }
}
