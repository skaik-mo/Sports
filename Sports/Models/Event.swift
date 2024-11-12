//
//  Event.swift
//  Sports
//
//  Created by Mohammed Skaik on 09/10/2024.
//

import SportTypeKit

class Event: Identifiable {
    var sport: SportType
    var key: Int?
    var date: String?
    var time: String?
    var final_result: String?
    var status: String?
    var league: League?
    var team: TeamSport?

    class func modelsFromDictionaryArray(sport: SportType?, array: [[String: Any]]?) -> [Event] {
        var events: [Event] = []
        for item in array ?? [] {
            if let event = Event(sport: sport ?? .football, dictionary: item) {
                events.append(event)
            }
        }
        return events
    }

    init?(sport: SportType, dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.sport = sport
        key = dictionary["event_key"] as? Int
        date = dictionary["event_date"] as? String
        time = dictionary["event_time"] as? String
        final_result = dictionary["event_final_result"] as? String
        status = dictionary["event_status"] as? String
        league = .init(dictionary: dictionary)
        setTeam(dictionary)
    }

    private func setTeam(_ dictionary: [String: Any]) {
        switch sport {
        case .football:
            team = FootballTeam(dictionary: dictionary)
        case .cricket:
            team = CricketTeam(dictionary: dictionary)
        case .basketball:
            team = BasketballTeam(dictionary: dictionary)
        case .tennis:
            team = TennisTeam(dictionary: dictionary)
        }
    }

}

// MARK: - Sort functions
extension Event {
    static func > (previous: Event, next: Event) -> Bool {
        if let previousDate = previous.date, let previousTime = previous.time, let nextDate = next.date, let nextTime = next.time, let previous = "\(previousDate) \(previousTime)".toDate, let next = "\(nextDate) \(nextTime)".toDate {
            return next > previous
        }
        return false
    }

    static func < (previous: Event, next: Event) -> Bool {
        if let previousDate = previous.date, let previousTime = previous.time, let nextDate = next.date, let nextTime = next.time, let previous = "\(previousDate) \(previousTime)".toDate, let next = "\(nextDate) \(nextTime)".toDate {
            return next < previous
        }
        return false
    }
}
