//
//  MappingUtils.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import ObjectMapper

struct Transforms {
    
    static let stringToIntTransform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        if let value = value {
            return Int(value)
        }
        return nil
    }, toJSON: {(value: Int?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
    })
    
    static let stringToURLTransform = TransformOf<URL, String>(fromJSON: { (value: String?) -> URL? in
        if let value = value {
            return URL(string: value)
        }
        return nil
    }, toJSON: {(value: URL?) -> String? in
        if let value = value {
            return String(describing: value)
        }
        return nil
    })
    
    static let stringToDateTransform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
        if let value = value {
            let dateFormatter = FormatterVendor.shared.utcDateFormatter
            return dateFormatter.date(from: value)
        }
        return nil
    }, toJSON: { (value: Date?) -> String? in
        if let value = value {
            let dateFormatter = FormatterVendor.shared.utcDateFormatter
            return dateFormatter.string(from: value)
        }
        return nil
    })
}
