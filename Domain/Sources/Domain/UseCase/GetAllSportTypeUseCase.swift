//
//  GetAllSportTypeUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public final class GetAllSportTypeUseCase {

    public init() {}

    public func execute() -> [SportType] {
        return SportType.allCases
    }
}
