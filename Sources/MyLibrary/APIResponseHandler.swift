//
//  APIResponseHandler.swift
//  Busapp
//
//  Created by Writayan Das on 09/11/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

typealias GenericAPIResponseResult<T: BaseMappable> = (successResponse: T?, errorResponse: APIError?, error: Error?)
typealias GenericAPIArrayResponseResult<T: BaseMappable> = (successResponse: [T]?, errorResponse: APIError?, error: Error?)
typealias GenericAPIVerificationResult = (success: Bool, errorResponse: Bool, error: Bool)

protocol APIResponseHandler: class {
}

extension APIResponseHandler {
     func verifyResponse<T: BaseMappable>(response: GenericAPIResponseResult<T>) -> GenericAPIVerificationResult {
        if response.successResponse == nil &&
            response.errorResponse == nil &&
            response.error == nil {
            return (true, false, false)
        }
        if response.successResponse != nil {
            return (true, false, false)
        } else {
            if let errorResponse = response.errorResponse {
                switch errorResponse {
                    // case .SESSION_NOT_FOUND,.USER_HAS_BEEN_SUSPENDED:
                case .code1050:
//                    AppDelegate.shared?.scrapUserDetails()
//                    AppDelegate.shared?.moveToHome(target: nil)
//                    AppDelegate.shared?.window?.makeToast(errorResponse.errorDescription)

                    ()
                default:
                    break
                }
                return (false, true, false)
            } else if let _ = response.error {
                if response.error as? JsonResponseError == JsonResponseError.sessionOut || response.error?.asAFError?.responseCode == 401 {
                    //session Expire
                }
                    return (false, false, true)
            } else {
                return (false, false, true)
            }
        }
    }
  /*  func verifyArrayResponse<T: BaseMappable>(response: GenericAPIArrayResponseResult<T>) -> GenericAPIVerificationResult {
        
        if response.successResponse == nil,
            response.errorResponse == nil,
            response.error == nil {
            return (true, false, false)
        }
        
        if response.successResponse != nil {
            return (true, false, false)
        } else {
            if let errorResponse = response.errorResponse {
                switch errorResponse {
                    //, .USER_HAS_BEEN_SUSPENDED:
                case .code1050:
//                    guard let vc = LoginViewController.load(with: nil)
//                        else {
//                            Log.e("LoginVC could not be loaded.")
//                            fatalError("User must be logged out.")
//                    }
//
//                    MQTTManager.shared.subscribedTopics.removeAll()
//                    MQTTManager.shared.disconnect()
//                    DataManager.shared.reset()
                    
                   // KeychainManager.shared.authToken = nil
                   // guard let vc = LoginVC.load(withDependency: nil) else {
                       // return (false, false, false)
                   // }
                   // AppDelegate.shared.clearUserData()
                    AppDelegate.shared?.scrapUserDetails()
                    AppDelegate.shared?.moveToHome(target: nil)
                    AppDelegate.shared?.window?.makeToast(errorResponse.errorDescription, completion: { [weak self] _ in
                        
                        
                        let nav = UINavigationController()
                        nav.isNavigationBarHidden = true
                        nav.viewControllers = [vc]
                        
                        AppDelegate.shared?.window?.replaceRootViewControllerWith(nav,
                                                                                  animated: true,
                                                                                  completion: nil)
                        
                        
                        
                    })
                    
                   
                    
                    
                   
//                    LoginManager().logOut()
//
//                    let navVC = PopNavigationController(rootViewController: vc)
//                    navVC.isNavigationBarHidden = true
//                    AppDelegate.shared.window?.replaceRootViewControllerWith(navVC,
//                                                                             animated: true,
//                                                                             completion: nil)
                default:
                    break
                }
                return (false, true, false)
            } else if let _ = response.error {
                return (false, false, true)
            } else {
                return (false, false, true)
            }
        }
    }*/
}
