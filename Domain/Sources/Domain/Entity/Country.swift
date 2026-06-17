//
//  Country.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

import Foundation

public struct Country {
    public let id: Int
    public let name: String
    public let logo: String?

    public init(id: Int, name: String, logo: String?) {
        self.id = id
        self.name = name
        self.logo = logo
    }
}
