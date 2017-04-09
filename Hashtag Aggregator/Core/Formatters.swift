//
//  Formatters.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation

class FormatterVendor {
    
    static let shared = FormatterVendor()
    
    let utcDateFormatter: DateFormatter
    let userDateFormatter: DateFormatter
    let twitterDateFormatter: DateFormatter
    
    init() {
        utcDateFormatter = DateFormatter()
        utcDateFormatter.timeZone = TimeZone(secondsFromGMT:0)
        utcDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        twitterDateFormatter = DateFormatter()
        twitterDateFormatter.timeZone = TimeZone(secondsFromGMT:0)
        twitterDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.fffffff"

        userDateFormatter = DateFormatter()
        userDateFormatter.timeZone = TimeZone.current
        userDateFormatter.dateFormat = "EEE HH:mm"
    }
}
