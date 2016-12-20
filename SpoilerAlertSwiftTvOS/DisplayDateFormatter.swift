//
//  DisplayDateFormatter.swift
//  SpoilerAlertSwiftTvOS
//
//  Created by Florian Pygmalion on 19/12/2016.
//  Copyright © 2016 One More Thing Studio. All rights reserved.
//

import UIKit

var displayDateWithFormatter: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter
        }()
    }

    return Static.instance
}

var displayDateServerWithFormatter: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter
        }()
    }

    return Static.instance
}

var displayDateNotification: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter
        }()
    }

    return Static.instance
}

var displayDate: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter
        }()
    }

    return Static.instance
}

var displayDateProfil: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter
        }()
    }

    return Static.instance
}

var displayHours: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter
        }()
    }

    return Static.instance
}

var dateFromDateAndHours: DateFormatter {

    struct Static {
        static let instance: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            return dateFormatter
        }()
    }

    return Static.instance

}
