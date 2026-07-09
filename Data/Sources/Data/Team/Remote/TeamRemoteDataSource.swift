//
//  TeamRemoteDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Domain

public final class TeamRemoteDataSource: Sendable {

    // MARK: - Properties
    private let client: APIClient

    // MARK: - Init
    public init(client: APIClient) {
        self.client = client
    }
}

// MARK: - Leagues
extension TeamRemoteDataSource {

    func getLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [TeamDto] {
        let response: ResponseDto<TeamDto> = try await client.perform(
            TeamBaseAppRequest(sportType: sportType, leagueId: leagueId)
        )
        guard response.success == 1 else {
            throw NetworkError.serverError(statusCode: 500)
        }
        return response.result
    }

}
