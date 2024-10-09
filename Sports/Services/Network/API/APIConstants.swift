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
    case BaseUrl = "https://apiv2.allsportsapi.com"
    case API = "/"
//    case API_key = "85929e14637e764a5975017acb8885cf850d6a179c83c61df84f70fd3bdf3bd9"
    case API_key = "25997407d691094b991bcbdd81a3a40c001bd5c377045f11ed26fa1e57d3248a"

    case API_leagues = "Leagues"
    case API_fixtures = "Fixtures"

}

var headers: HTTPHeaders {
    let headers: HTTPHeaders = []
    return headers
}
