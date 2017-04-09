//
//  MessagesViewModel.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import UIKit

class MessagesViewModel: NSObject, UITableViewDataSource {
    
    private var messages: [Message]
    
    private let model: MessagesModelType
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIElementsIdentifiers.messageCell, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]

        return cell
    }
    
    init(model: MessagesModelType) {
        self.model = model
        self.messages = model.messages
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(updateDataSource), name: messagesNotification, object: nil)
    }
    
    func updateDataSource() {
        self.messages = model.messages
    }
    
    func refreshData(completion: @escaping () -> Void) {
        model.refreshData(completion: completion)
    }
}
