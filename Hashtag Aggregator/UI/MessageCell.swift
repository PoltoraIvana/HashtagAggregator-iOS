//
//  MessageCell.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UserNameLabel!
    @IBOutlet weak var networkId: NetworkIdLabel!
    @IBOutlet weak var dateLabel: DateLabel!
    @IBOutlet weak var body: MessageBodyLabel!
    @IBOutlet weak var hashtag: HashtagLabel!
    @IBOutlet weak var networkIcon: UIImageView!
    
    var url: URL?
    
    var message: Message! {
        didSet {
            setupCell()
        }
    }
    
    func setupCell() {
        let cell = self
        
        let dateFormatter = FormatterVendor.shared.userDateFormatter
        
        cell.hashtag.text = message.hashTag
        cell.userName.text = message.user?.userName
        cell.networkId.text = ""
        cell.dateLabel.text = dateFormatter.string(for: message.postDate)
        cell.body.text = message.body
        cell.networkIcon.image = message.networkType?.image
        
        if let network = message.networkType {
            switch network {
            case .twitter:
                self.url = message.user?.url
            case .vk:
                let urlString = "https://vk.com/\(message.user!.profileId!)?w=wall\(message.user!.networkId!)_\(message.networkId!)/all"
                self.url = URL(string: urlString)
            }
        }
        
        if let avatarUrl = message.user?.avatar {
            DispatchQueue.global(qos: .userInteractive).async {
                if let data = try? Data(contentsOf: avatarUrl) {
                    DispatchQueue.main.async {
                        cell.userAvatar.image = UIImage(data: data)
                    }
                }
            }
        } else {
            cell.userAvatar.image = UIImage()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        networkIcon.image = UIImage()
    }
    
}
