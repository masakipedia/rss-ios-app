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

    init() {
        url = URL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")!
    }
    
    func itemsCount() -> Int {
        return feed?.items?.count ?? 0
    }
    
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

