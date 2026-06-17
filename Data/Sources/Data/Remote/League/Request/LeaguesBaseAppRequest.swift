//
//  LeaguesBaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Networking

final class LeaguesBaseAppRequest: BaseAppRequest {
    override var method: HTTPMethod { .get }
    override var parameters: Parameters {
        var params = super.parameters
        params["met"] = "Leagues"
        return params
    }
}
