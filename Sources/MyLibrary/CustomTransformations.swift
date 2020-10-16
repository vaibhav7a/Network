//
//  CustomTransformations.swift
//  Busapp
//
//  Created by Writayan Das on 09/11/18.
//  Copyright © 2018 Innofied Solution Pvt. Ltd. All rights reserved.
//

import ObjectMapper

struct CustomTransformations {
    // default Int to APIError
    static let apiErrorCodeTransformation = TransformOf<APIError, Int>(fromJSON: { (value: Int?) -> APIError? in
        // transform value from Int? to APIError?
        if let value = value {
            return APIError(rawValue: value)
        } else {
            return nil
        }
    }, toJSON: { (value: APIError?) -> Int? in
        // transform value from APIError? to Int?
        if let value = value {
            return value.rawValue
        } else {
            return nil
        }
    })
    //String to Gender
  /*  static let genderTransformation = TransformOf<Gender, String>(fromJSON: { (value: String?) -> Gender? in
        // transform value from String? to Gender?
        if let value = value {
            return Gender(rawValue: value)
        } else {
            return nil
        }
    }, toJSON: { (value: Gender?) -> String? in
        // transform value from Gender? to String?
        if let value = value {
            return value.rawValue
        } else {
            return nil
        }
    })*/

}
