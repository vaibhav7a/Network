//
//  Created by Writayan Das on 17/05/17.
//  Copyright © 2017 Traxsource. All rights reserved.
//

import Foundation

enum JsonResponseError: Error {
    case unexpectedResponse
    case unreachableNetwork
    case sessionOut
}

extension JsonResponseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unexpectedResponse:
            return "Oops! Received an unexpected response from the server."
        case .unreachableNetwork:
            return "We're sorry, an internet connection could not be established."
        case .sessionOut:
            return "Session expired. Please login again."
        }
    }
}
