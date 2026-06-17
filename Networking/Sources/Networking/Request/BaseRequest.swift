//
//  BaseRequest.swift
//  Networking
//
//  Created by Mohammed Skaik on 13/06/2026.
//

import Foundation

open class BaseRequest {
    public init() {}

    open var baseUrl: String { "" }
    open var endpoint: String { "" }
    open var method: HTTPMethod { .get }
    open var parameters: Parameters { [:] }
    open var headers: [String: String] { [:] }
    open var files: [BaseFile] { [] }
}
