//
//  Router.swift
//  SpoilerAlertSwiftTvOS
//
//  Created by Florian Pygmalion on 19/12/2016.
//  Copyright © 2016 One More Thing Studio. All rights reserved.
//

import Foundation
import Alamofire

// swiftlint:disable:next missing_docs
public enum Router: URLRequestConvertible {

    static let baseURLString = "http://localhost:8090/"

    case GetSeries()

    var method: HTTPMethod {
        switch self {
        case .GetSeries:
            return .get
        }
    }

    var path: String {
        switch self {
        case .GetSeries:
            return "series"
        }
    }

    var parameters: [String: AnyObject]? {
        switch self {
        case .GetSeries:
            return nil
        }
    }

    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue

        switch self {
        case .GetSeries:
            break
        } // let it this way and don't make a default case (you may think you will not forget to handle new cases but you will)

        if let params = self.parameters {
            print("Parameters -> \(params)")
            return try URLEncoding.queryString.encode(mutableURLRequest, with: params)
        }
        return mutableURLRequest
    }

    // swiftlint:disable:next missing_docs
    public func performRequest(completionHandler: @escaping (AnyObject?, NetworkingError?) -> Void) {
        request(self).responseJSON { (response) -> Void in
            switch response.result {
            case .failure(_):
                completionHandler(nil, NetworkingError.Unknown)
            case .success(let json):
                if let responseURL = response.response {
                    switch responseURL.statusCode {
                    case 200, 201, 204:
                        completionHandler(json as AnyObject?, nil)
                    case 404:
                        completionHandler(nil, NetworkingError.PageNotFound)
                    case 409:
                        completionHandler(nil, NetworkingError.ConflictError)
                    case 500:
                        completionHandler(nil, NetworkingError.ServerError)
                    default:
                        print(responseURL)
                        print("WARNING : status code \(responseURL.statusCode) not handled")
                        completionHandler(nil, NetworkingError.Unknown)
                    }
                }
            }
        }
    }

}
