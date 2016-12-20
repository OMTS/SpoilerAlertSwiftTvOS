//
//  Serie.swift
//  SpoilerAlertSwiftTvOS
//
//  Created by Florian Pygmalion on 19/12/2016.
//  Copyright © 2016 One More Thing Studio. All rights reserved.
//

import Foundation
import SwiftyJSON
import Networking

public class Serie {

    public var id: String!
    public var name: String!
    public var image: String!
    public var date: Date!

    private func fillWith(_ hash: JSON) {
        if hash["id"].object as? String != nil {
            id = hash["id"].stringValue
        }
        if hash["name"].object as? String != nil {
            name = hash["name"].stringValue
        }
        if hash["image"].object as? String != nil {
            image = hash["image"].stringValue
        }
        if hash["date"].object as? String != nil {
            date = displayDateServerWithFormatter.date(from: hash["date"].stringValue)
        }
    }

    public class func createSerieWith(_ json: JSON) -> Serie {
        let serie = Serie()
        serie.fillWith(json)

        return serie
    }

    public class func getAllSeries(completionHandler: @escaping ([Serie]?, NetworkingError?) -> Void) {
        Router.GetSeries().performRequest { (json, error) in
            if let error = error {
                print(error)
                completionHandler(nil, error)
            } else if let json = json {
                let json = JSON(json)
                let series = json.arrayValue.map { json -> Serie in
                    let serie = Serie.createSerieWith(json)
                    return serie
                }
                completionHandler(series, nil)
            }
        }
    }

}
