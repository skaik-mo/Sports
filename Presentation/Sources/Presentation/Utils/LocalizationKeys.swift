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
        public static func title(_ sportType: String) -> String {
            String(format: "leagues.title".localized, sportType)
        }

        public static func empty(_ sportType: String) -> String {
            String(format: "leagues.empty".localized, sportType)
        }

    }

    enum General {
        static let retry = "general.retry".localized
    }

    enum Error {
        public static let unauthorized = "error.unauthorized".localized
        public static let forbidden = "error.forbidden".localized
        public static let notFound = "error.not_found".localized
        public static let serverError = "error.server".localized
        public static let noInternet = "error.no_internet".localized
        public static let timeout = "error.timeout".localized
        public static let decodingFailed = "error.decoding".localized
        public static let noDataFound = "error.no_data_found".localized
        public static let dateCalculation = "error.date_calculation".localized
        public static let invalidDate = "error.invalid_date".localized
        public static let unknown = "error.unknown".localized
    }

}
