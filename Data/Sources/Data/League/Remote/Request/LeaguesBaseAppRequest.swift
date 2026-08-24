//
//  LeaguesBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Networking
import Domain

struct LeaguesBaseAppRequest: BaseAppRequest {
    let sportType: SportType
    var method: HTTPMethod { .get }
    var parameters: Parameters {
        var params = baseParameters
        params["met"] = "Leagues"
        return params
    }
}
