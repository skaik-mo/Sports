//
//  NetworkManager.swift
//  Networking
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Alamofire
import Foundation

public final class NetworkManager: NetworkManagerProtocol {

    // MARK: - Properties
    private let session: Session
    private let tokenInterceptor: TokenInterceptorProtocol?

    // MARK: - Init
    public init(tokenInterceptor: TokenInterceptorProtocol? = nil) {
        self.tokenInterceptor = tokenInterceptor
        session = Session()
    }
}

// MARK: - Request
extension NetworkManager {

    public func request(_ request: BaseRequest) async throws -> Data {
        guard let url = URL(string: request.baseUrl + request.endpoint) else {
            throw NetworkError.unknown(URLError(.badURL))
        }

        return try await sendRequest(url: url, request: request, isRetry: false)
    }

    private func sendRequest(url: URL, request: BaseRequest, isRetry: Bool) async throws -> Data {
        let response = await execute(buildDataRequest(url: url, request: request))

        if !isRetry,
           let interceptor = tokenInterceptor,
           response.response?.statusCode == 401 {
            do {
                try await interceptor.refreshToken()
                return try await sendRequest(url: url, request: request, isRetry: true)
            } catch {
                interceptor.clearTokens()
                throw NetworkError.unauthorized
            }
        }

        return try handle(response)
    }
}

// MARK: - Build Request
private extension NetworkManager {

    private func buildDataRequest(url: URL, request: BaseRequest) -> DataRequest {
        request.files.isEmpty
            ? normalRequest(url: url, request: request)
            : multipartRequest(url: url, request: request)
    }

    private func normalRequest(url: URL, request: BaseRequest) -> DataRequest {
        session.request(
            url,
            method: request.method,
            parameters: request.parameters.isEmpty ? nil : request.parameters,
            encoding: request.method == .get
                ? URLEncoding.default
                : JSONEncoding.default,
            headers: buildHeaders(from: request)
        )
    }

    private func multipartRequest(url: URL, request: BaseRequest) -> DataRequest {
        session.upload(
            multipartFormData: { multiPart in
                request.parameters.getMultiPart(multiPart: multiPart)
                for file in request.files {
                    multiPart.append(
                        file.data,
                        withName: file.name,
                        fileName: file.fileName,
                        mimeType: file.mimeType
                    )
                }
            },
            to: url,
            usingThreshold: UInt64(),
            method: request.method,
            headers: buildHeaders(from: request)
        )
    }
}

// MARK: - Headers
private extension NetworkManager {

    private func buildHeaders(from request: BaseRequest) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Accept",       value: "application/json")
        headers.add(name: "Content-Type", value: "application/json")

        if let token = tokenInterceptor?.accessToken() {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }

        for (key, value) in request.headers {
            headers.add(name: key, value: value)
        }

        return headers
    }
}

// MARK: - Response
private extension NetworkManager {

    private func execute(_ dataRequest: DataRequest) async -> AFDataResponse<Data> {
        await dataRequest
            .validate(statusCode: 200..<300)
            .serializingData()
            .response
    }

    private func handle(_ response: AFDataResponse<Data>) throws -> Data {
        switch response.result {
        case .success(let data): return data
        case .failure(let error): throw NetworkError.from(response, error)
        }
    }
}
