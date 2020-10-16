//
//  APIError.swift
//  Busapp
//
//  Created by Writayan Das on 09/11/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

public enum APIError: Int, Error {
    case code201 = 201
    case code401 = 401
    case code501 = 501
    case code700 = 700
    case code701 = 701
    case code702 = 702
    case code710 = 710
    case code800 = 800
    case code801 = 801
    case code803 = 803
    case code804 = 804
    case code809 = 809
    //
    case code901 = 901
    case code902 = 902
    case code903 = 903
    case code904 = 904
    case code905 = 905
    case code906 = 906
    case code910 = 910
    case code908 = 908
    case code955 = 955
   //
    case code1000 = 1000
    case code1001 = 1001
    case code1002 = 1002
    case code1005 = 1005
    case code1007 = 1007
    case code1008 = 1008
    case code1020 = 1020
    case code1050 = 1050
    case code1051 = 1051
    case noInternet = -1009
    case timeOut = -1001
    case code608 = 608
    case UNKNOWNERROR =  402
}
extension APIError: LocalizedError {
     public var errorDescription: String? {
        switch self {
        case .code201:
            return "code201"
        case .code401:
            return "code401"
        case .code501:
            return "code501"
        case .code700:
            return "code700"
        case .code701:
            return "code701"
        case .code702:
            return "code702"
        case .code710:
            return "code710"
        case .code800:
            return "code800"
        case .code801:
            return "code801"
        case .code803:
            return "code803"
        case .code804:
            return "code804"
        case .code809:
            return "code809"
        case .code901:
            return "code901"
        case .code902:
            return "code902"
        case .code903:
            return "code903"
        case .code904:
            return "code904"
        case .code905:
            return "code905"
        case .code906:
            return "code906"
        case .code908:
            return "code908"
        case .code910:
            return "code910"
        case .code1000:
             return "code1000"
        case .code1001:
            return "code1001"
        case .code1002:
            return "code1002"
        case .code1005:
            return "code1005"
        case .code1007:
            return "code1007"
        case .code1008:
            return "code1008"
        case .code1020:
            return "code1020"
        case .code1050:
            //AppDelegate.shared?.scrapUserDetails()
            //AppDelegate.shared?.moveToHome(target: nil)
            return "code1050"
        case .code1051:
            return "code1051"
        case .UNKNOWNERROR:
            return "UNKNOWN_ERROR"
        case .code955:
            return "code955"
        case.code608:
            return "code608"

        default:
            return "SomethingWentWrong"
        }

    }
}
