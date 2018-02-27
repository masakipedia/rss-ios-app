//
//  DataViewController.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import UIKit
import WebKit

class DataViewController: UIViewController {
    
    var index: Int!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func loadView() {
        // load xib file
        if let view = UINib(nibName: "DataViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWKWebView()
    }
    
    func initWKWebView() {
        
        // Refresh Control setting
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshWebView), for: UIControlEvents.valueChanged)
        webView.scrollView.addSubview(refreshControl)
        
        // content setting
        titleLabel.text = RSSFeedModel.shared.feed?.items?[index].title ?? ""
        timeLabel.text = String(describing: RSSFeedModel.shared.feed?.items?[index].pubDate ?? Date())
        webView.loadHTMLString(RSSFeedModel.shared.feed?.items?[index].description ?? "", baseURL: nil)
        
    }
    
    @objc func refreshWebView(sender: UIRefreshControl) {
        webView.load(URLRequest(url: URL(string: RSSFeedModel.shared.feed?.items?[index].link ?? "")!))
        sender.endRefreshing()
    }
    
}


