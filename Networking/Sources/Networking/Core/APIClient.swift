//
//  APIClient.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation

public final class APIClient: Sendable {

    // MARK: - Properties
    private let network: NetworkManagerProtocol
    private let decoder: JSONDecoder
    private let errorParser: APIErrorParserProtocol?

    // MARK: - Init
    public init(
        network: NetworkManagerProtocol,
        decoder: JSONDecoder = .default,
        errorParser: APIErrorParserProtocol? = nil
    ) {
        self.network = network
        self.decoder = decoder
        self.errorParser = errorParser
    }
}

extension APIClient {

    private func performRaw(_ request: BaseRequest) async throws -> Data {
        do {
            let data = try await network.request(request)

            if let apiError = errorParser?.parse(data) {
                throw apiError
            }

            return data
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }

    // MARK: - With Response Body
    public func perform<T: Decodable>(_ request: BaseRequest) async throws -> T {
        let data = try await performRaw(request)
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.unknown(error)
        }
    }

    // MARK: - No Response Body
    public func perform(_ request: BaseRequest) async throws {
        _ = try await performRaw(request)
    }
}
