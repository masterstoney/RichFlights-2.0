//
//  DateExtension.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/19/21.
//

import UIKit

extension Date {
    
    var skypickerDate: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: self)
        }
    }
    
    
    static func localizedDateString(timestamp: String, utcProper: Bool = true) -> String {
        let iso8601Formatter = ISO8601DateFormatter()
        iso8601Formatter.formatOptions = [.withInternetDateTime,.withFractionalSeconds]
        guard let date = iso8601Formatter.date(from: timestamp) else {return "N/A"}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        if !utcProper {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        return dateFormatter.string(from: date)
    }
    
    static func dayDifference(_ firstTimestamp: String, with secondTimestamp: String) -> Int {
        let iso8601Formatter = ISO8601DateFormatter()
        iso8601Formatter.formatOptions = [.withInternetDateTime,.withFractionalSeconds]
        guard let date = iso8601Formatter.date(from: firstTimestamp) else {return 0}
        guard let secondDate = iso8601Formatter.date(from: secondTimestamp) else {return 0}
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.component(.day, from: secondDate) - calendar.component(.day, from: date)
    }
    
    static func timeAsString(duration: Int) -> String {
        let timeInterval = TimeInterval(duration)
        return timeAsString(duration: timeInterval)
    }
    
    static func timeAsString(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        return formatter.string(from: duration) ?? "N/A"
    }
    
}
