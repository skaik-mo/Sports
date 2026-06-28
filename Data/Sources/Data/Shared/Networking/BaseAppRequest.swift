//
//  BaseAppRequest.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import Networking
import Domain

open class BaseAppRequest: BaseRequest {
    private let sportType: SportType

    init(sportType: SportType) {
        self.sportType = sportType
    }

    override open var baseUrl: String {
        APIConstants.baseUrl
    }

    open override var endpoint: String {
        self.sportType.path
    }

    open override var parameters: Parameters {
        ["APIkey": APIConstants.apiKey]
    }

    open override var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
}
