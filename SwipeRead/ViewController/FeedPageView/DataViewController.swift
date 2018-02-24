//
//  DataViewController.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    override func loadView() {
        // load xib file
        if let view = UINib(nibName: "DataViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    // vocabulary book index
    var index: Int!
    
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        feedTitle.text = RSSFeedModel.shared.feed?.items?[index].title ?? "[no title]"
        feedDescription.text = RSSFeedModel.shared.feed?.items?[index].description ?? "[no description]"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}


