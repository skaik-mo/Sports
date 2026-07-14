//
//  League.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public struct League: Sendable {
    public let id: Int
    public let name: String
    public let logo: String?
    public let country: Country

    public init(id: Int, name: String, logo: String?, country: Country) {
        self.id = id
        self.name = name
        self.logo = logo
        self.country = country
    }
}
