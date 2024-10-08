//
//  Sports.swift
//  Sports
//
//  Created by Mohammed Skaik on 29/09/2024.
//

import SwiftUI

enum Sports: String, CaseIterable, Identifiable {
    var id: Self { self }
    case football
    case cricket
    case basketball
    case tennis
    var title: String {
        switch self {
        case .football:
            return "Football"
        case .basketball:
            return "Basketball"
        case .cricket:
            return "Cricket"
        case .tennis:
            return "Tennis"
        }
    }
    var image: ImageResource {
        switch self {
        case .football:
            return .football
        case .basketball:
            return .basketball
        case .cricket:
            return .cricket
        case .tennis:
            return .tennis
        }
    }

    var icon: String {
        switch self {
        case .football:
            return "soccerball.inverse"
        case .basketball:
            return "basketball.fill"
        case .cricket:
            return "cricket.ball.fill"
        case .tennis:
            return "tennisball.fill"
        }
    }

    var endPoint: String {
        return "\(APIConstants.API.rawValue)\(self.rawValue)"
    }

}
