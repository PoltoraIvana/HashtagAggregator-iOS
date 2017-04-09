//
//  NetworkModels.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import ObjectMapper

enum Network: Int {
    case vk
    case twitter
    
    var image: UIImage? {
        switch self {
        case .twitter:
            return UIImage(named:"twitter-logo")
        case .vk:
            return UIImage(named:"vk-logo")
        }
    }
}

/*
 {"id":0,
 "networkId":"339763261",
 "userName":"Gomez Gonzalez",
 "profileId":"gomez.gonzalez",
 "url":null,
 "avatar50":"https://pp.userapi.com/c627917/v627917261/2952e/ga4ZlQC33QI.jpg"}
 */

struct User: Mappable {
    
    var id: Int?
    var userName: String?
    var profileId: String?
    
    var networkType: Network?
    var networkId: String?
    
    var url: URL?
    var avatar: URL?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        networkId <- map["networkId"]
        userName <- map["userName"]
        profileId <- map["profileId"]
        url <- (map["url"], Transforms.stringToURLTransform)
        avatar <- (map["avatar50"], Transforms.stringToURLTransform)
    }
}

/*
 {"id":0,
 "body":"#smallestmessagefortest1488 lol",
 "hashTag":"#smallestmessagefortest1488",
 "mediaType":0,
 "postDate":"2017-04-04T20:22:33",
 "user": User,
 "networkId":"39"}
 */

struct Message: Mappable {
    
    var id: Int?
    var networkId: String?
    
    var body: String?
    var hashTag: String?
    
    private var mediaType: Int?
    
    var networkType: Network? {
        if let mediaType = mediaType {
            return Network(rawValue: mediaType)
        } else {
            return nil
        }
    }
    
    private var _postDate: String? {
        didSet {
            if let _postDate = _postDate {
                if let networkType = networkType {
                    switch networkType {
                    case .twitter:
                        let dateFormatter = FormatterVendor.shared.twitterDateFormatter
                        self.postDate = dateFormatter.date(from: _postDate)
                    case .vk:
                        let dateFormatter = FormatterVendor.shared.utcDateFormatter
                        self.postDate = dateFormatter.date(from: _postDate)
                    }
                }
            }
        }
    }
    
    var postDate: Date?
    
    var user: User? {
        didSet {
            if user != nil {
                user!.networkType = self.networkType
            }
        }
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        body <- map["body"]
        hashTag <- map["hashTag"]
        mediaType <- map["mediaType"]
        
        _postDate <- map["postDate"]
        user <- map["user"]
        
        networkId <- map["networkId"]
    }
}
