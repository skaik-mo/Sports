//
//  LeagueRemoteDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Networking

public final class LeagueRemoteDataSource {

    // MARK: - Properties
    private let client: APIClient

    // MARK: - Init
    public init(client: APIClient) {
        self.client = client
    }
}

// MARK: - Leagues
extension LeagueRemoteDataSource {

    func getAllLeagues(sportDto: SportTypeDto) async throws -> [LeagueDto] {
        let response: ResponseDto<LeagueDto> = try await client.perform(
            LeaguesBaseAppRequest(sportDto: sportDto)
        )
        guard response.success == 1 else {
            throw NetworkError.serverError(statusCode: 500)
        }
        return response.result
    }

    
}
