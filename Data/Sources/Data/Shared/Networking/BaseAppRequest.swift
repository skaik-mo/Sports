//
//  BaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Networking
import Domain

protocol BaseAppRequest: BaseRequest {
    var sportType: SportType { get }
}

extension BaseAppRequest {
    var baseUrl: String { APIConstants.baseUrl }
    var path: String { sportType.path }
    var headers: [String: String] { ["Content-Type": "application/json"] }

    var baseParameters: Parameters {
        ["APIkey": APIConstants.apiKey]
    }
}
