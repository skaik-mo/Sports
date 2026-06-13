//
//  APIClient.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation

public final class APIClient {

    // MARK: - Properties
    private let network: NetworkManagerProtocol
    private let decoder: JSONDecoder

    // MARK: - Init
    public init(
        network: NetworkManagerProtocol,
        decoder: JSONDecoder = .default
    ) {
        self.network = network
        self.decoder = decoder
    }
}

// MARK: - With Response Body
extension APIClient {

    public func perform<T: Decodable>(_ request: BaseRequest) async throws -> T {
        do {
            let data = try await network.request(request)
            return try decoder.decode(T.self, from: data)
        } catch let error as NetworkError {
            throw error
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}

// MARK: - No Response Body
extension APIClient {

    public func perform(_ request: BaseRequest) async throws {
        do {
            _ = try await network.request(request)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
