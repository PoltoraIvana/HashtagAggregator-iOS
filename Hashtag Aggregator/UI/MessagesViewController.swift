//
//  ViewController.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import UIKit

class MessagesViewController: UITableViewController {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: MessagesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        viewModel = MessagesViewModel(model: MessagesModel())
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = viewModel
        
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        messagesTableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: messagesNotification, object: nil)
    }
    
    func updateData() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        activityView.isHidden = true
        
        messagesTableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        
        UIView.animate(withDuration: 0.3) { [weak self] _ in
            self!.view.layoutIfNeeded()
        }
        messagesTableView.reloadData()
    }
    
    func refresh() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] _ -> Void in
            self!.viewModel.refreshData() {
                DispatchQueue.main.async {
                    self!.messagesTableView.reloadData()
                    self!.refreshControl?.endRefreshing()
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MessageCell
        performSegue(withIdentifier: UIElementsIdentifiers.segueToWebView, sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIElementsIdentifiers.segueToWebView {
            if sender is MessageCell {
                let vc = segue.destination as! URLViewController
                vc.url = (sender as! MessageCell).url
            }
        }
    }
    
}

