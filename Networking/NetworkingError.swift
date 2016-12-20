//
//  NetworkingError.swift
//  SpoilerAlertSwiftTvOS
//
//  Created by Florian Pygmalion on 19/12/2016.
//  Copyright © 2016 One More Thing Studio. All rights reserved.
//

import Foundation

// swiftlint:disable:next missing_docs
public enum NetworkingError {

    case Unknown,
    NotConnectedToInternet,
    ServerError,
    ConflictError,
    InvalidRequest,
    PageNotFound,
    AlamofireError,
    NoError

    func toError() -> NSError {
        return NSError(domain:"SpoilerAlertError", code: 0, userInfo: nil)
    }

}

extension NetworkingError: Error {

    var nsError: NSError {
        get {
            return toError()
        }
    }
    
}
