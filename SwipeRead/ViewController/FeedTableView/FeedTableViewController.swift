//
//  ListViewController.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var headerView: UIView!
    
    override func loadView() {
        // load xib file
        if let view = UINib(nibName: "FeedTableViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // セルのないところに線をなくす
        tableView.tableFooterView = UIView()
        
        // header view
        let headerHight = self.view.frame.height * 0.15
        tableView.contentInset.top = headerHight
        headerView = UIView(frame: CGRect(x: 0, y: -(self.view.safeAreaInsets.top + tableView.contentInset.top), width: self.view.frame.width, height: headerHight))
        headerView.backgroundColor = UIColor.black
        tableView.addSubview(headerView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RSSModel.shared.dataCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UINib(nibName: "ListViewCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! ListViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
        cell.term.text = RSSModel.shared.terms[indexPath.row]
        return cell
    }
    

}

// MARK: - Table View Delegate


// MARK: - Fix header view when scrolling

extension FeedTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard headerView != nil else {
            return
        }
        if scrollView.contentOffset.y < -(self.view.safeAreaInsets.top + tableView.contentInset.top) {
            self.headerView.frame = CGRect(x: 0, y: scrollView.contentOffset.y + self.view.safeAreaInsets.top, width: self.view.frame.width, height: headerView.frame.height)
        } else {
            self.headerView.frame = CGRect(x: 0, y: -tableView.contentInset.top, width: self.view.frame.width, height: headerView.frame.height)
        }
    }
}


// MARK: - Memory warning

extension FeedTableViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
