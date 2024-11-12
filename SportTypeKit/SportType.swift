//
//  SportType.swift
//  SportTypeKit
//
//  Created by Mohammed Skaik on 12/11/2024.
//

public enum SportType: String, CaseIterable, Identifiable, Codable {
    public var id: Self { self }
    case football
    case cricket
    case basketball
    case tennis
    public var title: String {
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

    public var icon: String {
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

}
