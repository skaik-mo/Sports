//
//  TeamBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Networking
import Domain

struct TeamBaseAppRequest: BaseAppRequest {
    let sportType: SportType
    let leagueId: Int
    var method: HTTPMethod { .get }
    var parameters: Parameters {
        var params = baseParameters
        params["met"] = "Teams"
        params["leagueId"] = leagueId
        return params
    }
}
