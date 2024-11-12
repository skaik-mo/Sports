//  Skaik_mo
//
//  APIConstants.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation
import Alamofire

enum APIConstants: String {

    // MARK: - BaseUrl
    case BaseUrl = "https://apiv2.allsportsapi.com/"
    case API_key = "4a02c7e8d44075adc769028f91d87329ecef52e1d7311b91ee4388a5f2ee68c9"

    case API_leagues = "Leagues"
    case API_fixtures = "Fixtures"

}

var headers: HTTPHeaders {
    let headers: HTTPHeaders = []
    return headers
}
