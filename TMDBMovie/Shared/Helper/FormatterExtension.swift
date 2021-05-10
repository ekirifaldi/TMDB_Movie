//
//  FormatterExtension.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

extension Formatter {
    static let iso8601standard: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "id")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = DateFormat.standardDateFormat
        return formatter
    }()
    
    static let iso8601timestamp: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "id")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = DateFormat.timestampDateFormat
        return formatter
    }()
}
