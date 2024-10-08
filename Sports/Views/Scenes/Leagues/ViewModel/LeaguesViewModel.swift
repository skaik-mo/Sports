//
//  LeaguesViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation

@Observable
class LeaguesViewModel {
    private var originalLeagues: [League] = []
    var leagues: [League] = []
    let title = "Leagues"
    var sport: Sports
    var alertManager: AlertManager?
    var progressManager: ProgressManager?
    var searchText: String = "" {
        didSet {
            findLeagues()
        }
    }

    init(sport: Sports) {
        self.sport = sport
    }

    func fetchLeagues(isShowLoader: Bool = true) {
        guard let alertManager, let progressManager else { return }
        let baseRequest = BaseRequest()
        baseRequest.end_point = sport.endPoint
        baseRequest.method = .get
        baseRequest.parameters = [
            "met": APIConstants.API_leagues.rawValue,
            "APIkey": APIConstants.API_key.rawValue
        ]
        _ = RequestBuilder(alertManager: alertManager, progressManager: progressManager).requestWithSuccessResponse(with: baseRequest, isShowLoader: isShowLoader, isShowMessage: true, success: { [weak self] response, code, message in
            let result = response["result"] as? [[String: Any]]
            self?.originalLeagues = League.modelsFromDictionaryArray(array: result)
            self?.leagues = self?.originalLeagues ?? []
        })
    }

    private func findLeagues() {
        guard !searchText.isEmpty else {
            leagues = originalLeagues
            return
        }
        leagues = originalLeagues.filter { $0.league_name?.lowercased().contains(searchText.lowercased()) ?? false }
    }

}
