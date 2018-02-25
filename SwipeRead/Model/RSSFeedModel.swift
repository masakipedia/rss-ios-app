//
//  RSSModel.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import FeedKit

class RSSFeedModel {
    
    // singleton
    static var shared = RSSFeedModel()
    
    var feed: RSSFeed?
    let url: URL
    var faviconUrlString = "https://www.google.com/s2/favicons?domain="

    init() {
        let urlString = "https://www.gizmodo.jp/index.xml"
        url = URL(string: urlString)!
        faviconUrlString += urlString
    }
    
    func itemsCount() -> Int {
        return feed?.items?.count ?? 0
    }
    
    
    /// Load RSS feed and display it in tableview
    ///
    /// - Parameter tableView: display tableview
    func loadRssFeed(tableView: UITableView) {
        let parser = FeedParser(URL: url)!
    
        // Parse asynchronously, not to block the UI.
        parser.parseAsync { [weak self] (result) in
            self?.feed = result.rssFeed
            
            // Then back to the Main thread to update the UI.
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }

}

