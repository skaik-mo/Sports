//
//  Team.swift
//  Sports
//
//  Created by Mohammed Skaik on 09/10/2024.
//

class Team: Identifiable {
    var key: Int?
    var name: String?
    var logo: String?

    init(key: Int?, name: String?, logo: String? = nil) {
        self.key = key
        self.name = name
        self.logo = logo
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "key": self.key,
            "name": self.name,
            "logo": self.logo,
        ]
        return dictionary as [String: Any]
    }
}

extension Team: Hashable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.key == rhs.key
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}
