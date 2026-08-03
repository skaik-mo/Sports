//
//  PlayerRemoteDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 03/08/2026.
//

import Networking
import Domain

public final class PlayerRemoteDataSource: Sendable {

    // MARK: - Properties
    private let client: APIClient

    // MARK: - Init
    public init(client: APIClient) {
        self.client = client
    }
}

extension PlayerRemoteDataSource {

    func getLeaguePlayers(sportType: SportType, leagueId: Int) async throws -> [PlayerDto] {
        let response: ResponseDto<PlayerDto> = try await client.perform(
            PlayerBaseAppRequest(sportType: sportType, leagueId: leagueId)
        )
        guard response.success == 1 else {
            throw NetworkError.serverError(statusCode: 500)
        }
        return response.result?.filter { $0.player_name != nil } ?? []
    }
}
