//
//  League.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//


class League: Identifiable {
    var league_key: Int?
    var league_name: String?
    var country_key: Int?
    var country_name: String?
    var league_logo: String?
    var country_logo: String?

    class func modelsFromDictionaryArray(array: [[String: Any]]?) -> [League] {
        var leagues: [League] = []
        for item in array ?? [] {
            if let league = League(dictionary: item) {
                leagues.append(league)
            }
        }
        return leagues
    }

    init(league_key: Int?, league_name: String?, country_key: Int?, country_name: String?, league_logo: String?, country_logo: String?) {
        self.league_key = league_key
        self.league_name = league_name
        self.country_key = country_key
        self.country_name = country_name
        self.league_logo = league_logo
        self.country_logo = country_logo
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        league_key = dictionary["league_key"] as? Int
        league_name = dictionary["league_name"] as? String
        country_key = dictionary["country_key"] as? Int
        country_name = dictionary["country_name"] as? String
        league_logo = dictionary["league_logo"] as? String
        country_logo = dictionary["country_logo"] as? String
    }


    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "league_key": self.league_key,
            "league_name": self.league_name,
            "country_key": self.country_key,
            "country_name": self.country_name,
            "league_logo": self.league_logo,
            "country_logo": self.country_logo
        ]
        return dictionary as [String: Any]
    }
}