//
//  EndPointType.swift
//  APIManager
//
//  Created by Vaibhav Jain on 02/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire
public protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var timeout: TimeInterval { get }
    var isAuthorization: Bool { get }
}





import Foundation
public protocol EndpointManager {
    static func setApiConfig(config: ApiConfig)
}

// MARK: - APIConfig
public struct ApiConfig {
    public var baseURL: String
    public let timeout: TimeInterval
    public let isAuthorization: Bool
    public let clientID, clientSecret: String?
    public init(baseURL: String,
         timeout: TimeInterval = 60.0,
         isAuthorization: Bool = true,
         clientID: String? = nil,
         clientSecret: String? = nil) {
        self.baseURL = baseURL
        self.timeout = timeout
        self.isAuthorization = isAuthorization
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
}
