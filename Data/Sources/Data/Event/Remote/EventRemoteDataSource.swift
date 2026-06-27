//
//  EventRemoteDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Foundation

public class EventRemoteDataSource {

    // MARK: - Properties
    private let client: APIClient

    // MARK: - Init
    public init(client: APIClient) {
        self.client = client
    }
}

extension EventRemoteDataSource {

    func getUpcomingEvents(sportDto: SportTypeDto, leagueId: Int) async throws -> [EventDto] {
        let oneMonthFromNow = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: .now
        )
        return try await getEvents(
            sportDto: sportDto,
            leagueId: leagueId,
            fromDate: .now,
            toDate: oneMonthFromNow
        )
    }

    func getLatestEvents(sportDto: SportTypeDto, leagueId: Int) async throws -> [EventDto] {
        let oneYearAgo = Calendar.current.date(
            byAdding: .year,
            value: -1,
            to: .now
        )
        return try await getEvents(
            sportDto: sportDto,
            leagueId: leagueId,
            fromDate: oneYearAgo,
            toDate: .now
        )
    }

    private func getEvents(sportDto: SportTypeDto, leagueId: Int, fromDate: Date?, toDate: Date?) async throws -> [EventDto] {
        guard let fromDate, let toDate else {
            throw DataException.dateCalculationFailed
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
            EventBaseAppRequest(sportDto: sportDto, extraParams: params)
        )
        guard response.success == 1 else {
            throw NetworkError.serverError(statusCode: 500)
        }
        return response.result
    }

}
