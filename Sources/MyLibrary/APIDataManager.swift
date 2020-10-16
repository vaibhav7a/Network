//
//  APIManager.swift
//  InstaExpress
//
//
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper

struct AppServerResponse<T: BaseMappable>: Mappable {
    var success: Bool!
    var apiError: APIError?
    var message: String?
    var data: T?
    init?(map: Map) {
        guard let _ = map.JSON["success"] else {
            Log.e("Success is not present.")
            return nil
        }
    }
    mutating func mapping(map: Map) {
        success <- map["success"]
        apiError <- (map["code"], CustomTransformations.apiErrorCodeTransformation)
        data <- map["data"]
        message <- map["message"]

    }
}

struct AppServerListResponse<T: BaseMappable>: Mappable {
    var success: Bool!
    var apiError: APIError?
    var data: [T]?
    init?(map: Map) {
        guard let _ = map.JSON["success"] else {
            Log.e("Success is not present.")
            return nil
        }
    }
    mutating func mapping(map: Map) {
        success <- map["success"]
        apiError <- (map["errorCode"], CustomTransformations.apiErrorCodeTransformation)
        data <- map["data"]
    }
}
public typealias GenericCompletion<T: BaseMappable> = (
    _ successResponse: T?,
    _ errorResponse: APIError?,
    _ error: Error?) -> Void

public typealias GenericArrayCompletion<T: BaseMappable> = (
    _ successResponse: [T]?,
    _ errorResponse: APIError?,
    _ error: Error?) -> Void
public enum ParameterType {
    case httpBody
    case queryString
}
public protocol APIDataManager: class {
}
extension APIDataManager {
    // API Call For Immutable Responses
        /// Method to make HTTP API call where the response is parsed as BaseMappable
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint  - describes URL and HTTP method
    ///   - parameters: key-value coded payload
    ///   - parameterType: payload encoding
    ///   - completion: block to be exceuted when the response is received
    @discardableResult
    public func makeAPICall<T: BaseMappable>(to endpoint: APIEndpoint,
                                      withParameters parameters: Parameters!,
                                      ofType parameterType: ParameterType = .httpBody,
                                      completion: @escaping GenericCompletion<T>) -> DataRequest {
        Log.i("Headers: \(APIHeader.shared.headers)")
        Log.i("Parameters: \(String(describing: parameters))")
        let dataRequest = AF.request(endpoint.baseURL + endpoint.path,
                                            method: endpoint.httpMethod,
                                            parameters: endpoint.parameter,
                                            encoding: parameterType == .queryString ? URLEncoding.queryString : JSONEncoding.default,
                                            headers: HTTPHeaders.init(APIHeader.shared.headers))
        .validate()
        .responseString { (response) in
            Log.i("Request URL: \(response.request?.url?.absoluteString ?? "")")
          //  Log.i("Response Data: \(response.result.value ?? "")")
            // check for http response code 200 or network timeout
            switch response.result {
            case .success(let responseString):
                   print(responseString)
                guard let parsedData = AppServerResponse<T>(JSONString: responseString) else {
                    completion(nil, nil, JsonResponseError.sessionOut)
                    return
                }
                if parsedData.success {
                    // DATA
                    guard let data = parsedData.data else {
                        // no data on succes true
                        completion(nil, nil, nil)
                        return
                    }
                    completion(data, nil, nil)
                } else {
                    // error
                    guard let apiError = parsedData.apiError else {
                        // no error code on false success
                        completion(nil, nil, APIError.UNKNOWNERROR)
                        return
                    }
                    completion(nil, apiError, nil)
                }
            case .failure(let error):
                Log.e("Failed Request: \(error.localizedDescription)")
                completion(nil, nil, error)
            }
        }
        dataRequest.resume()
        return dataRequest
    }
}
// MARK: - Array Response
extension APIDataManager {
/// Method to make HTTP API call where the response is parsed as [BaseMappable]
///
/// - Parameters:
///   - endpoint: Endpoint  - describes URL and HTTP method
///   - parameters: key-value coded payload
///   - parameterType: payload encoding
///   - completion: block to be exceuted when the response is received
    @discardableResult
    func makeAPICallForArrayResponse<T: BaseMappable>(to endpoint: APIEndpoint,
                                                      withParameters parameters: Parameters? = nil,
                                                      ofType parameterType: ParameterType = .httpBody,
                                                      completion: @escaping GenericArrayCompletion<T>) -> DataRequest {
            Log.i("Headers: \(APIHeader.shared.headers)")
            Log.i("Parameters: \(String(describing: parameters))")
        let dataRequest = AF.request(endpoint.baseURL,
                                     method: endpoint.httpMethod,
                                     parameters: parameters,
                                     encoding: parameterType == .queryString ? URLEncoding.queryString : JSONEncoding.default,
                                     headers: endpoint.headers)
            .validate()
            .responseString { (response) in
                Log.i("Request URL: \(response.request?.url?.absoluteString ?? "")")
                // check for http response code 200 or network timeout
                switch (response.result) {
                case .success(let responseString):
                    print(responseString)
                    guard let parsedData = AppServerListResponse<T>(JSONString: responseString) else {
                                              // No Response for 200
                        completion(nil, nil, JsonResponseError.unexpectedResponse)
                        return
                    }
                    if parsedData.success {
                        // DATA
                        guard let data = parsedData.data else {
                                // no data on succes true
                                completion(nil, nil, nil)
                                return
                        }
                        completion(data, nil, nil)
                    } else {
                        // error
                        guard let apiError = parsedData.apiError else {
                            // no error code on false success
                            completion(nil, nil, APIError.UNKNOWNERROR)
                            return
                        }
                        completion(nil, apiError, nil)
                    }
                case .failure(let error):
                    Log.e("Failed Request: \(error.localizedDescription)")
                    completion(nil, nil, error)
                }
        }
            dataRequest.resume()
            return dataRequest
    }
}
