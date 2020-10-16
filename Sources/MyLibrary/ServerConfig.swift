//
//  ServerConfig.swift
//  Pro-Skool Guardian
//
//  Created by Dipayan Ghose on 7/19/18.
//  Copyright © 2018 Dipayan Ghose. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

enum APIMode {
    case localDevelopment
    case production
    case qaTesting
    case development
}

struct ServerConfig {
    // MARK: - Static stored properties
    static var baseURL = ""
    static var mqttURL = ""
    static var mqttPort = UInt16()
    // MARK: Setting mode changes the stored URLs
    static var mode: APIMode = .production {
        didSet {
            switch mode {
            case .localDevelopment:
                baseURL = "http://192.168.0.16:8000/api/v1"
                //mqttURL = "192.168.0.33"
                //mqttPort = 1883
            case .production:
                baseURL = "http://13.235.136.143:7000/api/v1"
                //mqttURL = ""
                // mqttPort = 1883
            case .qaTesting:
                baseURL = "http://13.235.136.143:7000/api/v1"
                // mqttURL = ""
                //mqttPort = 1883
            case .development:
                baseURL = "https://d527dt0656u8b.cloudfront.net/silk-music-app/dev-admin/public/api"
                //mqttURL = ""
                //mqttPort = 1883
            }
        }
    }
    // MARK: - Initializer
    init(withMode mode: APIMode) {
        ServerConfig.mode = mode
    }
}

struct APIHeader {
    internal enum HeaderKeys: String {
        case contentType = "Content-Type"
        case accept = "Accept"
        case uuid = "x-auth-deviceid"
        case deviceType = "x-auth-devicetype"
        case pushToken = "device-token"
        case authToken = "Authorization"
    }
    static let shared = APIHeader()
    var uuidString: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
//    var pushToken: String? {
//        return SilkUserDefaults.shared.pushToken
//    }
//    var authToken: String? {
//        return SilkUserDefaults.shared.apiToken
//    }
    var headers: [String: String] {
        var headerDict = [
            HeaderKeys.contentType.rawValue: "application/json",
            HeaderKeys.accept.rawValue: "application/json",
            HeaderKeys.uuid.rawValue: "2",
            HeaderKeys.deviceType.rawValue: "ios"
        ]
//        if let pushToken = pushToken {
//            headerDict[HeaderKeys.pushToken.rawValue] = pushToken
//        }
        //remove it
//        headerDict[HeaderKeys.authToken.rawValue] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNzcxMzExZjhjZDMyYzkyNTVjZWI0YTJhYTFjM2I2NWIzNmFjMzM4NDk3MWJmMmQ0MjFhOGVlMDQxNmNjOWEyOTM1NjVhDk5Nzc3YzVjMjYiLCJpYXQiOjE1OTk0NTI5MDksIm5iZiI6MTU5OTQ1MjkwOSwiZXhwIjoxNjMwOTg4OTA5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.EvLrX7OLXXvJ8NRSc6buAtjbAI3TNxMaOkYW_2FbrpP_RYVe0NVAIN7GHn1O4-aMng-Erv1sE3uhpiW_N6YO6hobebAqMwuP7v8wz_9lyRKC6ji-YXASbBrQ0AFXtYcjS525nCXBLRcjKkKpqCaabw55LQYEx4WqeixIbWrRN5_wz25iylBRMyCtBYlt5zUfCyH_uTQA4E5GxFJ62cMT5CyDkJx8z10HbX_kyqidFXKSY8OMwlhYRi-y2_rPShSCDdBVPFB4ob1SJsWA6uxALv77Fc6gF9DiwyYsmA8x0cB5ntrgqpcwDLJUm7c46SKR5EbGjD4FxXHRkTrEt3EoCQolHNhjgoCHmcmRpC4jQTWgfQX8OFpQvmXSYSlWQRGrYCXR_RHQNrqHtgJd2QVRkrB37VDBO0LmVEPRv_GcFLOawJ-GRi6sg34lL72sIMhtKBeRbJY4bkYMnunrZA7BzFnrM25sIvzd_OgY7bktgGiIcCd_I2qFJmuBIjiCc8f7p6jMYsusekheIOgDMyD0niMCTCuF-7CKzIeJuYNG71J9pv3_cYgGT9xmVIWCXnNlMK6I9EY3r3PXQFynJvS9S_GM9UEPmiNIYJUUxZrQAr3rL6KXUTJzkGm6M9OCa2OiWW0xLMPFVkZqDVy-yKKTpK8ai_PslZ88MoR0KqPPch4"
//        if let authToken = authToken {
//            headerDict[HeaderKeys.authToken.rawValue] = "Bearer \(authToken)"
//        }
        return headerDict
    }
    /* var multipartHeaders: HTTPHeaders {
     
     var headerDict = [
     "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)",
     HeaderKeys.accept.rawValue: "application/json",
     HeaderKeys.uuid.rawValue: uuidString,
     HeaderKeys.deviceType.rawValue: "2"
     ]
     
     if let pushToken = pushToken {
     headerDict[HeaderKeys.pushToken.rawValue] = pushToken
     }
     
     if let authToken = authToken {
     headerDict[HeaderKeys.authToken.rawValue] = authToken
     }
     
     //        if let langKey = langKey {
     //            headerDict[HeaderKeys.language.rawValue] = langKey
     //        }
     
     return headerDict
     }*/
}
