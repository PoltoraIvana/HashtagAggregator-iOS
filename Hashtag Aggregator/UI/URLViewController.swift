//
//  URLViewController.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/9/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import UIKit

class URLViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let url = url {
            loadUrl(url: url)
        }
    }
    
    func loadUrl(url: URL) {
        webView.loadRequest(URLRequest(url: url))
    }
    
}
