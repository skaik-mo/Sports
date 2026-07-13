//
//  Team.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public struct Team: Equatable, Sendable {
    public let id:Int
    public let name:String?
    public let logoUrl:String?

    public init(id: Int, name: String?, logoUrl: String?) {
        self.id = id
        self.name = name
        self.logoUrl = logoUrl
    }
}
