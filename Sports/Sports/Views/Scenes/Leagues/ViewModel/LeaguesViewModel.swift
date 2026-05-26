//
//  LeaguesViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation

@Observable
@MainActor
class LeaguesViewModel {
    private var originalLeagues: [League] = []
    private let coordinator: Coordinator
    let networkService: NetworkService
    var leagues: [League] = []
    var title: String {
        "\(sport.title) Leagues"
    }
    var sport: Sports
    var emptyDataTitle: String {
        "No \(sport.title) Leagues Available"
    }
    var searchText: String = "" {
        didSet {
            findLeagues()
        }
    }

    init(coordinator: Coordinator, networkService: NetworkService, sport: Sports) {
        self.coordinator = coordinator
        self.networkService = networkService
        self.sport = sport
    }

    func setAlertManagerAndProgressManager(alert: AlertManager, progress: ProgressManager) {
        let requestBuilder = networkService as? RequestBuilder
        requestBuilder?.alertManager = alert
        requestBuilder?.progressManager = progress
    }

    func fetchLeagues(isShowLoader: Bool = true) {
        let baseRequest = BaseRequest()
        baseRequest.end_point = sport.endPoint
        baseRequest.method = .get
        baseRequest.parameters = [
            "met": APIConstants.API_leagues.rawValue,
            "APIkey": APIConstants.API_key.rawValue
        ]
        _ = self.networkService.requestWithSuccessResponse(with: baseRequest, isShowLoader: isShowLoader, isShowMessage: true, success: { [weak self] response, code, message in
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

    func navigateToEvents(_ league: League) {
        coordinator.navigateToEvents(sport, league)
    }

}
