//
//  DataViewController.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    var index: Int!
    
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedDescription: UITextView!
    
    
    override func loadView() {
        // load xib file
        if let view = UINib(nibName: "DataViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedTitle.text = RSSFeedModel.shared.feed?.items?[index].title ?? "[no title]"
        feedDescription.text = RSSFeedModel.shared.feed?.items?[index].description ?? "[no description]"
    }
    
}


