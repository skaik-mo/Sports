//
//  EventsViewModel.swift
//  Sports
//
//  Created by Mohammed Skaik on 08/10/2024.
//

import Foundation

@Observable
class EventsViewModel {
    let coordinator: Coordinator
    let padding: CGFloat = 15
    let title = "Events"
    let upcomingTitle = "Upcoming Events"
    let latestTitle = "Latest Events"
    let teamTitle = "Teams"
    let vsTitle = "VS"
    var league: League
    var sport: Sports
    private var events: [Event] = []
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: Set<Team> = []
    var alertManager: AlertManager?
    var progressManager: ProgressManager?
    let dateNow = Date.now
    var formDate: String
    var toDate: String { (dateNow._add(months: 1) ?? dateNow)._stringDate }
    var emptyDataTitle: String {
        "No \(league.league_name ?? "") Matches Found from \(formDate) to \(toDate)"
    }
    var isEmptyData: Bool {
        self.events.isEmpty && !(progressManager?.showProgress == true)
    }

    init(coordinator: Coordinator, sport: Sports, league: League) {
        self.coordinator = coordinator
        self.sport = sport
        self.league = league
        if sport == .football {
            formDate = (dateNow._add(months: -4) ?? dateNow)._stringDate
        } else {
            formDate = (dateNow._add(years: -1) ?? dateNow)._stringDate
        }
    }

    func clear() {
        self.events.removeAll()
        self.upcomingEvents.removeAll()
        self.latestEvents.removeAll()
        self.teams.removeAll()
    }

    func fetchEvents(isShowLoader: Bool = true) {
        guard let alertManager, let progressManager else { return }
        let baseRequest = BaseRequest()
        baseRequest.end_point = sport.endPoint
        baseRequest.method = .get
        baseRequest.parameters = [
            "met": APIConstants.API_fixtures.rawValue,
            "APIkey": APIConstants.API_key.rawValue,
            "leagueId": league.league_key ?? -1,
            "from": formDate,
            "to": toDate,
        ]
        _ = RequestBuilder(alertManager: alertManager, progressManager: progressManager).requestWithSuccessResponse(with: baseRequest) { [weak self] response, code, message in
            let result = response["result"] as? [[String: Any]]
            self?.events = Event.modelsFromDictionaryArray(sport: self?.sport, array: result)
            self?.events.forEach { event in
                if let date = event.date, let time = event.time, let eventDate = "\(date) \(time)".toDate, eventDate >= Date.now {
                    self?.upcomingEvents.append(event)
                } else if !(event.status?.isEmpty ?? true) {
                    self?.latestEvents.append(event)
                }
                if let homeTeam = event.team?.homeTeam, let awayTeam = event.team?.awayTeam {
                    self?.teams.insert(homeTeam)
                    self?.teams.insert(awayTeam)
                }
            }
            self?.upcomingEvents = self?.upcomingEvents.sorted(by: >) ?? []
            self?.latestEvents = self?.latestEvents.sorted(by: <) ?? []
        }
    }
}
