//
//  TeamRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain

public class TeamRepositoryImpl: TeamRepository {

    // MARK: - Properties
    private let remote: TeamRemoteDataSource

    // MARK: - Init
    public init(
        remote: TeamRemoteDataSource,
    ) {
        self.remote = remote
    }

}

extension TeamRepositoryImpl {

    public func getLeagueTeams(sport: SportType, leagueId: Int) async throws -> [Team] {
        let sportDto = SportTypeDto.sportMapper(from: sport)
        let dtos = try await remote.getLeagueTeams(sportDto: sportDto, leagueId: leagueId)
        return dtos.map { $0.toDomain() }
    }
}
