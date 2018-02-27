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
    private(set) var allFeedsURLString: [String] = [
        "https://www.huffingtonpost.jp/feeds/index.xml",
        "https://www.gizmodo.jp/index.xml",
        "https://www.lifehacker.jp/feed/index.xml",
        "https://www.buildinsider.net/rss",
        "https://codezine.jp/rss/new/20/index.xml",
        "http://feed.rssad.jp/rss/gigazine/rss_2.0",
        "http://getnews.jp/feed/ext/orig",
        "https://rss.allabout.co.jp/aa/latest/",
        "https://techable.jp/feed",
        "https://liginc.co.jp/feed",
        "view-source:https://www.hackingwithswift.com/articles/rss",
    ]
    private(set) var allFeedsName: [String] = [
        "HuffPost Japan",
        "ギズモード・ジャパン",
        "ライフハッカー [日本版]",
        "Build Insider",
        "CodeZine",
        "GIGAZINE",
        "ガジェット通信",
        "All About（オールアバウト）",
        "Techable（テッカブル）",
        "株式会社LIG",
        "HACKING WITH SWIFT",
    ]
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
    
    
    func loadRssFeedTitle(url: URL) -> String{
        let parser = FeedParser(URL: url)!
        return parser.parse().rssFeed?.title ?? "[no title]"
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
    /// - Parameter urlString: string url
    /// - Returns: favicon image url
    func getFaviconURL(stringURL: String) -> URL {
        var splitURL = stringURL.split(separator: "/")
        guard splitURL.count > 1 else {
            return URL(string: "https://www.google.com/s2/favicons?domain=" + "nothing")!
        }
        return URL(string: "https://www.google.com/s2/favicons?domain=" + splitURL[0] + "//" + splitURL[1])!
    }
    
}


// MARK: - I disabled ATS. So, i did comment out.

extension RSSFeedModel {


//    /// rss feed setter
//    /// feed url must be ATS(https)
//    ///
//    /// - Parameter stringURL: rss feed url (https)
//    /// - Returns: Whether it succeeded or not
//    func setFeedURL(stringURL: String) -> Bool {
//
//        let isATS = { (_ stringURL: String) -> Bool in
//            let strSplited = stringURL.split(separator: "/")
//            return "https:" == strSplited[0]
//        }
//
//        guard isATS(stringURL) else {
//            return false
//        }
//
//        allFeedsURLString.append(stringURL)
//        allFeedsName.append(loadRssFeedTitle(url: URL(string: stringURL)!))
//        return true
//    }

}

