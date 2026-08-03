//
//  PlayerBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 03/08/2026.
//

import Networking
import Domain

class PlayerBaseAppRequest: BaseAppRequest {
    private var params: Parameters = [:]

    override var method: HTTPMethod { .get }

    override var parameters: Parameters {
        params["met"] = "Players"
        return params
    }

    init(sportType: SportType, leagueId: Int) {
        super.init(sportType: sportType)
        self.params = super.parameters
        params["leagueId"] = leagueId
    }
}
