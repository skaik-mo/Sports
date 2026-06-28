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

    public func getLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Team] {
        let dtos = try await remote.getLeagueTeams(sportType: sportType, leagueId: leagueId)
        return dtos.map { $0.toDomain() }
    }
}
