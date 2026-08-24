//
//  PlayerBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 03/08/2026.
//

import Networking
import Domain

struct PlayerBaseAppRequest: BaseAppRequest {
    let sportType: SportType
    let leagueId: Int
    var method: HTTPMethod { .get }
    var parameters: Parameters {
        var params = baseParameters
        params["met"] = "Players"
        params["leagueId"] = leagueId
        return params
    }
}
