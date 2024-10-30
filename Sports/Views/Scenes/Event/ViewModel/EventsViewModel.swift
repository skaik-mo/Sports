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
    let networkService: NetworkService
    let dataService = FavoriteDataService()
    var favoriteImage: String = "star"
    let padding: CGFloat = 15
    let title = "Matches"
    let upcomingTitle = "Upcoming Matches"
    let latestTitle = "Latest Matches"
    let teamTitle = "Teams"
    let vsTitle = "VS"
    var league: League
    var sport: Sports
    private(set) var events: [Event] = []
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: Set<Team> = []
    let dateNow = Date.now
    var formDate: String
    var toDate: String { (dateNow._add(months: 12) ?? dateNow)._stringDate }
    var emptyDataTitle: String {
        "No \(league.league_name ?? "") Matches Found from \(formDate) to \(toDate)"
    }
    var isEmptyData: Bool {
        let showProgress = (networkService as? RequestBuilder)?.progressManager?.showProgress ?? false
        return self.events.isEmpty && !(showProgress)
    }

    init(coordinator: Coordinator, networkService: NetworkService, sport: Sports, league: League) {
        self.coordinator = coordinator
        self.networkService = networkService
        self.sport = sport
        self.league = league
        if sport == .football {
            formDate = (dateNow._add(months: -4) ?? dateNow)._stringDate
        } else {
            formDate = (dateNow._add(years: -1) ?? dateNow)._stringDate
        }
    }

    func setAlertManagerAndProgressManager(alert: AlertManager, progress: ProgressManager) {
        let requestBuilder = networkService as? RequestBuilder
        requestBuilder?.alertManager = alert
        requestBuilder?.progressManager = progress
    }

    func clear() {
        self.events.removeAll()
        self.upcomingEvents.removeAll()
        self.latestEvents.removeAll()
        self.teams.removeAll()
    }

    func fetchEvents(isShowLoader: Bool = true) {
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
        _ = networkService.requestWithSuccessResponse(with: baseRequest, isShowLoader: isShowLoader, isShowMessage: true) { [weak self] response, code, message in
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

    func setFavoriteImage() {
        let favoriteExists = dataService.checkIfFavoriteExists(.init(league: league, sport: sport))
        favoriteImage = favoriteExists == nil ? "star" : "star.fill"
    }

    func setFavorite() {
        dataService.setFavorite(.init(league: league, sport: sport))
        setFavoriteImage()
    }

}
