//
//  NetworkManagerProtocol.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation

public protocol NetworkManagerProtocol {
    func request(_ request: BaseRequest) async throws -> Data
}
