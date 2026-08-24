//
//  BaseRequest.swift
//  Networking
//
//  Created by Mohammed Skaik on 13/06/2026.
//

import Foundation

public protocol BaseRequest {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var headers: [String: String] { get }
    var files: [BaseFile] { get }
}

public extension BaseRequest {
    var baseUrl: String { "" }
    var path: String { "" }
    var method: HTTPMethod { .get }
    var parameters: Parameters { [:] }
    var headers: [String: String] { [:] }
    var files: [BaseFile] { [] }
}
