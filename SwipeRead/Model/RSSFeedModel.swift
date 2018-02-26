//
//  RSSModel.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import FeedKit


// MARK: - Field

class RSSFeedModel {
    
    // singleton
    static var shared = RSSFeedModel()
    
    var feed: RSSFeed?
    private(set) var allFeedsURLString: [String] = ["https://www.gizmodo.jp/index.xml", "https://www.lifehacker.jp/feed/index.xml"]
    private(set) var allFeedsName: [String] = ["ギズモード・ジャパン", "ライフハッカー [日本版]"]
    private(set) var url: URL!
}


// MARK: - Method

extension RSSFeedModel {
    

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

}


// MARK: - Property

extension RSSFeedModel {
    
    
    /// url setter
    ///
    /// - Parameter urlString: string url
    func setCurrentURL(urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            print("\nURL Error: The urlString can not convert to url.\n\n")
            return false
        }
        self.url = url
        return true
    }
    
    
    /// feed items count getter
    ///
    /// - Returns: items count
    func getItemsCount() -> Int {
        return feed?.items?.count ?? 0
    }
    
    
    /// favicon image url getter
    /// The url is using google api.
    /// https://www.google.com/s2/favicons?domain="want site url"
    ///
    /// - Returns: favicon image url
    func getFaviconURL() -> URL {
        var splitURL = self.url.absoluteString.split(separator: "/")
        guard splitURL.count > 1 else {
            return URL(string: "https://www.google.com/s2/favicons?domain=" + self.url.absoluteString)!
        }
        return URL(string: "https://www.google.com/s2/favicons?domain=" + splitURL[0] + "//" + splitURL[1])!
    }
    
}


