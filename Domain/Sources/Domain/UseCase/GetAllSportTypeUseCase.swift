//
//  GetAllSportTypeUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

class GetAllSportTypeUseCase {
    func execute() -> [SportType] {
        return SportType.allCases
    }
}
