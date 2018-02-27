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
    @IBOutlet weak var headerView: UIView!
    
    override func loadView() {
        // load xib file
        if let view = UINib(nibName: "DataViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWKWebView()
        initContent()
    }
    
}


// MARK: - initialyze WKWebView

extension DataViewController {
    
    func initWKWebView() {
        
        // Refresh Control setting
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshWebView), for: UIControlEvents.valueChanged)
        webView.scrollView.addSubview(refreshControl)
        
    }
    
    @objc func refreshWebView(sender: UIRefreshControl) {
        webView.load(URLRequest(url: URL(string: RSSFeedModel.shared.feed?.items?[index].link ?? "")!))
        sender.endRefreshing()
        
        removeHeaderView()
    }
    
    func removeHeaderView() {
        timeLabel.alpha = 0
        titleLabel.alpha = 0
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    
}


// MARK: - initialyze Content

extension DataViewController {
    
    func initContent() {
        
        // content setting
        titleLabel.text = RSSFeedModel.shared.feed?.items?[index].title ?? ""
        timeLabel.text = String(describing: RSSFeedModel.shared.feed?.items?[index].pubDate ?? Date())
        let html = "<font size=\"25px\">" + (RSSFeedModel.shared.feed?.items?[index].description ?? "") + "</font>"
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    
}
