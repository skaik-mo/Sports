//
//  Event.swift
//  Sports
//
//  Created by Mohammed Skaik on 09/10/2024.
//


class Event: Identifiable {
    var key: Int?
    var date: String?
    var time: String?
    var ft_result: String?
    var status: String?
    var league: League?
    var homeTeam: Team?
    var awayTeam: Team?
    class func modelsFromDictionaryArray(array: [[String: Any]]?) -> [Event] {
        var events: [Event] = []
        for item in array ?? [] {
            if let event = Event(dictionary: item) {
                events.append(event)
            }
        }
        return events
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        key = dictionary["event_key"] as? Int
        date = dictionary["event_date"] as? String
        time = dictionary["event_time"] as? String
        ft_result = dictionary["event_ft_result"] as? String
        status = dictionary["event_status"] as? String
        league = .init(dictionary: dictionary)
        homeTeam = .init(key: dictionary["home_team_key"] as? Int, name: dictionary["event_home_team"] as? String, logo: dictionary["home_team_logo"] as? String)
        awayTeam = .init(key: dictionary["away_team_key"] as? Int, name: dictionary["event_away_team"] as? String, logo: dictionary["away_team_logo"] as? String)

    }


    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "event_key": self.key,
            "event_date": self.date,
            "event_time": self.time,
            "event_ft_result": self.ft_result,
            "event_status": self.status,
            "league": self.league?.getDictionary(),
            "homeTeam": self.homeTeam?.getDictionary(),
            "awayTeam": self.awayTeam?.getDictionary(),
        ]
        return dictionary as [String: Any]
    }
}
