//
//  MessagesModel.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation

let messagesNotification = Notification.Name("received-messages")

protocol MessagesModelType {
    var messages: [Message] { get set }
    func refreshData(completion: @escaping () -> Void)
}

class MessagesModel: MessagesModelType {
    
    let apiClient = ApiClient.shared

    var messages: [Message] = [Message]() {
        didSet {
            notify()
        }
    }
    
    init() {
        
        apiClient.getMesages(for: "Microsoft") { success, messages -> Void in
            if success {
                if let messages = messages {
                    self.messages = messages
                }
            }
        }
    }
    
    func notify() {
        NotificationCenter.default.post(name: messagesNotification, object: messages)
    }
    
    func refreshData(completion: @escaping () -> Void) {
        apiClient.getMesages(for: "Microsoft") { success, messages -> Void in
            if success {
                if let messages = messages {
                    self.messages = messages
                    completion()
                }
            }
        }
    }
    
    
}
