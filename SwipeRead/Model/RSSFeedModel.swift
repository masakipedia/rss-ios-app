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
    var allFeedsURLString: [String] = ["https://www.gizmodo.jp/index.xml", "https://www.lifehacker.jp/feed/index.xml"]
    var url: URL!

    
    /// Return number of items that the current URL has
    ///
    /// - Returns: items count
    func itemsCount() -> Int {
        return feed?.items?.count ?? 0
    }
    
    
    /// Load RSS feed and display it in tableview
    ///
    /// - Parameter tableView: display at tableview
    func loadRssFeed(tableView: UITableView) {
        let parser = FeedParser(URL: self.url)!
    
        // Parse asynchronously, not to block the UI.
        parser.parseAsync { [weak self] (result) in
            self?.feed = result.rssFeed
            
            // Then back to the Main thread to update the UI.
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }

    
    /// Return favicon image url. The url is using google api.
    /// https://www.google.com/s2/favicons?domain="want site url"
    ///
    /// - Returns: favicon image url
    func faviconURL() -> URL {
        var splitURL = self.url.absoluteString.split(separator: "/")
        guard splitURL.count > 1 else {
            return self.url
        }
        return URL(string: "https://www.google.com/s2/favicons?domain=" + splitURL[0] + "//" + splitURL[1])!
    }
    
}

