//
//  TeamSport.swift
//  Sports
//
//  Created by Mohammed Skaik on 17/10/2024.
//

protocol TeamSport {
    var homeTeam: Team? { get }
    var awayTeam: Team? { get }
}

class FootballTeam: TeamSport {
    var homeTeam: Team?
    var awayTeam: Team?

    init(dictionary: [String: Any]) {
        homeTeam = .init(key: dictionary["home_team_key"] as? Int, name: dictionary["event_home_team"] as? String, logo: dictionary["home_team_logo"] as? String)
        awayTeam = .init(key: dictionary["away_team_key"] as? Int, name: dictionary["event_away_team"] as? String, logo: dictionary["away_team_logo"] as? String)
    }
}

class CricketTeam: TeamSport {
    var homeTeam: Team?
    var awayTeam: Team?

    init(dictionary: [String: Any]) {
        homeTeam = .init(key: dictionary["home_team_key"] as? Int, name: dictionary["event_home_team"] as? String, logo: dictionary["event_home_team_logo"] as? String)
        awayTeam = .init(key: dictionary["away_team_key"] as? Int, name: dictionary["event_away_team"] as? String, logo: dictionary["event_away_team_logo"] as? String)
    }
}

class BasketballTeam: TeamSport {
    var homeTeam: Team?
    var awayTeam: Team?

    init(dictionary: [String: Any]) {
        homeTeam = .init(key: dictionary["home_team_key"] as? Int, name: dictionary["event_home_team"] as? String, logo: dictionary["event_home_team_logo"] as? String)
        awayTeam = .init(key: dictionary["away_team_key"] as? Int, name: dictionary["event_away_team"] as? String, logo: dictionary["event_away_team_logo"] as? String)
    }
}

class TennisTeam: TeamSport {
    var homeTeam: Team?
    var awayTeam: Team?

    init(dictionary: [String: Any]) {
        homeTeam = .init(key: dictionary["first_player_key"] as? Int, name: dictionary["event_first_player"] as? String, logo: dictionary["event_first_player_logo"] as? String)
        awayTeam = .init(key: dictionary["second_player_key"] as? Int, name: dictionary["event_second_player"] as? String, logo: dictionary["event_second_player_logo"] as? String)
    }
}
