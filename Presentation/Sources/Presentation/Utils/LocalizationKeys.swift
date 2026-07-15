//
//  LocalizationKeys.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

enum L10n {

    enum Home {
        static let title = "home.title".localized
        static let footballTitle = "home.sport.football".localized
        static let basketballTitle = "home.sport.basketball".localized
        static let cricketTitle = "home.sport.cricket".localized
        static let tennisTitle = "home.sport.tennis".localized
    }

    enum Leagues {
        static func title(_ sportType: String) -> String {
            String(format: "leagues.title".localized, sportType)
        }

        static func empty(_ sportType: String) -> String {
            String(format: "leagues.empty".localized, sportType)
        }
    }

    enum Events {
        static let vs: String = "events.vs".localized
        static let upcomingMatches: String = "events.upcoming_matches".localized
        static let latest_matches: String = "events.latest_matches".localized
        static let title: String = "events.title".localized
        static let teams: String = "events.teams".localized
        static let players: String = "events.players".localized
        static let empty: String = "events.empty".localized
    }

    enum Favorite {
        static let title: String = "favorite.title".localized
        static let empty: String = "favorite.empty".localized
        static let remove: String = "favorite.remove".localized
    }

    enum General {
        static let retry = "general.retry".localized
    }

    enum Error {
        static let unauthorized = "error.unauthorized".localized
        static let forbidden = "error.forbidden".localized
        static let notFound = "error.not_found".localized
        static let serverError = "error.server".localized
        static let noInternet = "error.no_internet".localized
        static let timeout = "error.timeout".localized
        static let decodingFailed = "error.decoding".localized
        static let noDataFound = "error.no_data_found".localized
        static let dateCalculation = "error.date_calculation".localized
        static let invalidDate = "error.invalid_date".localized
        static let unknown = "error.unknown".localized
    }

}
