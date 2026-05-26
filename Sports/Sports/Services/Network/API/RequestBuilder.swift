//  Skaik_mo
//
//  RequestBuilder.swift
//  Sports
//
//  Created by Mohammed Skaik on 05/10/2024.
//

import Foundation
import Alamofire

typealias successHandler = ((_ response: [String: Any], _ code: Int, _ message: String) -> Void)?
typealias failureHandler = ((_ response: [String: Any], _ code: Int, _ error: Error) -> Void)?


protocol NetworkService {
    func requestWithSuccessResponse(with request: BaseRequest, isShowLoader: Bool, isShowMessage: Bool, success: successHandler) -> NetworkService
}

class RequestBuilder: NetworkService {
    var alertManager: AlertManager?
    var progressManager: ProgressManager?

    private var didFinishRequest: (() -> Void)?

    func handlerDidFinishRequest(handler: (() -> Void)?) -> RequestBuilder {
        self.didFinishRequest = handler
        return self
    }

    private let manager = NetworkReachabilityManager(host: "www.apple.com")

    var isNetworkReachable: Bool {
        return manager?.isReachable ?? false
    }

    private var offlineLoad: (() -> Void)?

    func handlerOfflineLoad(handler: (() -> Void)?) -> RequestBuilder {
        self.offlineLoad = handler
        return self
    }

    func showLoader(_ isLoading: Bool, progress: Double? = nil) {
        guard let progressManager else { return }
        if let progress, isLoading {
            progressManager.value = progress
            progressManager.showProgress = true
            return
        }
        if isLoading {
            progressManager.showProgress = true
        } else {
            progressManager.showProgress = false
        }
    }

    func requestWithSuccessResponse(with request: BaseRequest, isShowLoader: Bool, isShowMessage: Bool, success: successHandler) -> NetworkService {
        self.request(with: request, isShowLoader: isShowLoader, isShowMessage: isShowMessage) { response, code, message in
            ResponseHandler.responseHandler(result: BaseResult.success(response: response), isShowMessage: isShowMessage, alertManager: self.alertManager)
            success?(response, code, message)
            self.didFinishRequest?()
        } failure: { response, code, error in
            ResponseHandler.responseHandler(result: BaseResult.failure(error: error, response: response), isShowMessage: isShowMessage, alertManager: self.alertManager)
            if !self.isNetworkReachable {
                debugPrint("offline")
                self.offlineLoad?()
                return
            }
            self.didFinishRequest?()
        }
        return self
    }

    func request(with request: BaseRequest, isShowLoader: Bool = true, isShowMessage: Bool = true, success: successHandler, failure: failureHandler) {
        guard let url = URL.init(string: request.base_url + request.end_point) else { return }
        debugPrint("=========> Request Start <=========")

        if request.files.count > 0 {
            if isShowLoader {
                self.showLoader(true)
            }
            debugPrint("=========> multipart Request <=========")
            AF.upload(multipartFormData: { multiPart in
                request.parameters.getMultiPart(multiPart: multiPart)
                for item in request.files {
                    if let data = item.data, let key_name = item.key_name, let fileName = item.name, let mimeType = item.mime_type {
                        multiPart.append(data, withName: key_name, fileName: fileName, mimeType: mimeType)
                    }
                }
            }, to: url, usingThreshold: UInt64(), method: request.method, headers: headers)
                .uploadProgress(queue: .main, closure: { progress in
                if isShowLoader {
                    self.showLoader(true, progress: progress.fractionCompleted)
                }
            }).responseString { result in
                if isShowLoader {
                    self.showLoader(false)
                }
                self.requestBuilderResponseHandler(result: result, success: success, failure: failure)
                debugPrint("=========> Request End <=========")
            }
        } else {
            debugPrint("=========> Normal Request <=========")
            if isShowLoader {
                self.showLoader(true)
            }
            AF.request(url, method: request.method, parameters: request.parameters, encoding: request.method == .get ? URLEncoding.default : JSONEncoding.default, headers: headers).responseString { result in
                if isShowLoader {
                    self.showLoader(false)
                }
                self.requestBuilderResponseHandler(result: result, success: success, failure: failure)
                debugPrint("=========> Request End <=========")
            }
        }
    }

    private func requestBuilderResponseHandler(result: AFDataResponse<String>, success: successHandler, failure: failureHandler) {
        debugPrint("URL => \(String(describing: result.response?.url))")
        switch result.result {
        case .success(_):
            guard let data = result.data else { return }
            do {
                var dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let baseResponse = BaseResponse.init(dictionary: dic)
                if baseResponse?.code == nil {
                    dic?["code"] = result.response?.statusCode
                    baseResponse?.code = dic?["code"] as? Int
                }
                if ResponseHandler.checkResponseValidity(baseResponse) {
                    success?(dic ?? [:], baseResponse?.code as? Int ?? 0, baseResponse?.message ?? "")
                } else {
                    let error = NSError.init(domain: "", code: baseResponse?.code as? Int ?? 0, userInfo: [NSLocalizedDescriptionKey: baseResponse?.message ?? "Sorry, the connection to our server failed"])
                    failure?(dic ?? [:], baseResponse?.code as? Int ?? 0, error)
                }
            } catch(let error) {
                failure?([:], result.response?.statusCode ?? 0, error)
            }
        case .failure(let error):
            failure?([:], result.response?.statusCode ?? 0, error)
        }
    }
}


extension Dictionary {
    func getMultiPart(multiPart: MultipartFormData, key: String? = nil) {
        for (dicKey, value) in self {
            var keY: String = (dicKey as? String) ?? ""
            if let key = key, key.count > 0 {
                keY = "\(key)[\(keY)]" //// address[tags][0][id]
            }
            if let temp = value as? String, let data = temp.data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            if let temp = value as? Int, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            if let temp = value as? Float, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            if let temp = value as? Double, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            if let temp = value as? Bool, let data = "\(temp)".data(using: .utf8) {
                multiPart.append(data, withName: keY)
            }
            if let item = value as? Dictionary { // address
                item.getMultiPart(multiPart: multiPart, key: keY)
            }
            if let temp = value as? [Dictionary] {
                for (index, item) in temp.enumerated() {
                    item.getMultiPart(multiPart: multiPart, key: keY + "[\(index)]")
                }
            }
        }
    }
}
