//
//  TableViewController.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/26.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import UIKit
import AlamofireImage

class RssListTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - Table view data source

extension RssListTableViewController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RSSFeedModel.shared.allFeedsURLString.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UINib(nibName: "RSSListTableViewCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! RSSListTableViewCell

        cell.titleLabel.text = RSSFeedModel.shared.allFeedsName[indexPath.row]
        configureImage(imageView: cell.faviconImageView,
                       URLString: RSSFeedModel.shared.getFaviconURL(stringURL: RSSFeedModel.shared.allFeedsURLString[indexPath.row]).absoluteString,
                       placeholderImage: UIImage(named: "placeholder")!)
        return cell
    }
    
}


// MARK: - Table View Delegate
    
extension RssListTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = RSSFeedModel.shared.setCurrentURL(urlString: RSSFeedModel.shared.allFeedsURLString[indexPath.row])
        showFeedWithIndex(indexPath.row)
    }
        
}


// MARK: - Navigation

extension RssListTableViewController {
    
    func showFeedWithIndex(_ index: Int) {
        // navigation item setting
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " Back", style: .plain, target: nil, action: nil)
        
        // next view controller
        let rvc: FeedTableViewController = storyboard!.instantiateViewController(withIdentifier: "FeedTableViewController") as! FeedTableViewController
        show(rvc, sender:nil)
    }
    
}



// MARK: - set image from url

extension RssListTableViewController {
    
    func configureImage(imageView: UIImageView, URLString: String, placeholderImage: UIImage) {
        let size = imageView.frame.size
        
        guard let url = URL(string: URLString) else {
            imageView.image = placeholderImage
            return
        }
        
        imageView.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: size.height * 0.15),
            imageTransition: .crossDissolve(0.2)
        )
    }
}

