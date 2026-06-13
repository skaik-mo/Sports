//
//  TokenInterceptorProtocol.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

public protocol TokenInterceptorProtocol {
    func accessToken() -> String?
    func refreshToken() async throws
    func clearTokens()
}
