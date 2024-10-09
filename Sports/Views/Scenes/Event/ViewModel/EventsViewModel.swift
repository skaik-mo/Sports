//
//  EventsViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 08/10/2024.
//

import Foundation

@Observable
class EventsViewModel {
    let padding: CGFloat = 15
    let title = "Events"
    let upcomingTitle = "Upcoming Events"
    let latestTitle = "Latest Events"
    let teamTitle = "Teams"
    let vsTitle = "VS"
    var leagueId: Int?
    var sport: Sports
    private var events: [Event] = []
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: Set<Team> = []
    var alertManager: AlertManager?
    var progressManager: ProgressManager?
    var emptyDataTitle: String {
        "No \(sport.title) Events Available"
    }
    var isEmptyData: Bool {
        self.events.isEmpty && !(progressManager?.showProgress == true)
    }

    init(sport: Sports, leagueId: Int?) {
        self.sport = sport
        self.leagueId = leagueId
    }

    func clear() {
        self.events.removeAll()
        self.upcomingEvents.removeAll()
        self.latestEvents.removeAll()
        self.teams.removeAll()
    }

    func fetchEvents(isShowLoader: Bool = true) {
        guard let alertManager, let progressManager else { return }
        let dateNow = Date.now
        let formDate: String = (dateNow._add(days: -15) ?? dateNow)._stringDate
        let toDate: String = (dateNow._add(days: 15) ?? dateNow)._stringDate
        let baseRequest = BaseRequest()
        baseRequest.end_point = sport.endPoint
        baseRequest.method = .get
        baseRequest.parameters = [
            "met": APIConstants.API_fixtures.rawValue,
            "APIkey": APIConstants.API_key.rawValue,
            "leagueId": leagueId ?? -1,
            "from": formDate,
            "to": toDate,
        ]
        _ = RequestBuilder(alertManager: alertManager, progressManager: progressManager).requestWithSuccessResponse(with: baseRequest) { [weak self] response, code, message in
            let result = response["result"] as? [[String: Any]]
            self?.events = Event.modelsFromDictionaryArray(array: result)
            self?.events.forEach { event in
                event.status?.isEmpty ?? true ? self?.upcomingEvents.append(event) : self?.latestEvents.append(event)

                if let homeTeam = event.homeTeam, let awayTeam = event.awayTeam {
                    self?.teams.insert(homeTeam)
                    self?.teams.insert(awayTeam)
                }
            }
        }
    }
}
