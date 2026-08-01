//
//  EventRemoteDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Foundation
import Domain

public final class EventRemoteDataSource: Sendable {

    // MARK: - Properties
    private let client: APIClient

    // MARK: - Init
    public init(client: APIClient) {
        self.client = client
    }
}

extension EventRemoteDataSource {

    func getUpcomingEvents(sportType: SportType, leagueId: Int) async throws -> [EventDto] {
        let oneMonthFromNow = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: .now
        )
        return try await getEvents(
            sportType: sportType,
            leagueId: leagueId,
            fromDate: .now,
            toDate: oneMonthFromNow
        )
    }

    func getLatestEvents(sportType: SportType, leagueId: Int) async throws -> [EventDto] {
        let oneYearAgo = Calendar.current.date(
            byAdding: .year,
            value: -1,
            to: .now
        )
        return try await getEvents(
            sportType: sportType,
            leagueId: leagueId,
            fromDate: oneYearAgo,
            toDate: .now
        )
    }

    private func getEvents(sportType: SportType, leagueId: Int, fromDate: Date?, toDate: Date?) async throws -> [EventDto] {
        guard let fromDate, let toDate else {
            throw DomainException.dateCalculationFailed
        }
        let formatter = DateFormatter.dateFormat(format: "yyyy-MM-dd")
        let startDate = formatter.string(from: fromDate)
        let endDate = formatter.string(from: toDate)
        let params: Parameters = [
            "leagueId" : leagueId,
            "from" : startDate,
            "to" : endDate,
        ]
        let response: ResponseDto<EventDto> =  try await client.perform(
            EventBaseAppRequest(sportType: sportType, extraParams: params)
        )
        guard response.success == 1 else {
            throw NetworkError.serverError(statusCode: 500)
        }
        return response.result ?? []
    }

}
