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
    case API_key = "85929e14637e764a5975017acb8885cf850d6a179c83c61df84f70fd3bdf3bd9"

    // MARK: - Football
    case API_football = "football"
    case API_leagues = "Leagues"


    var endPint: String {
        return "\(APIConstants.API.rawValue)\(self.rawValue)"
    }
}

var headers: HTTPHeaders {
    let headers: HTTPHeaders = []
    return headers
}
