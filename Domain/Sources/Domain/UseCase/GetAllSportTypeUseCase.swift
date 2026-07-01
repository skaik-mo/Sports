//
//  GetAllSportTypeUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public class GetAllSportTypeUseCase {

    public init() {}

    public func execute() -> [SportType] {
        return SportType.allCases
    }
}
