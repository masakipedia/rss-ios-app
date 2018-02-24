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
        if let tableView = UINib(nibName: "FeedTableViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UITableView {
            self.tableView = tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // Eliminate the line where there is no cell
        tableView.tableFooterView = UIView()
        
        // Add header view
        let headerHight = self.view.frame.height * 0.15
        tableView.contentInset.top = headerHight
        headerView = UIView(frame: CGRect(x: 0, y: -(self.view.safeAreaInsets.top + tableView.contentInset.top), width: self.view.frame.width, height: headerHight))
        headerView.backgroundColor = UIColor.black
        tableView.addSubview(headerView)
    }
    
}


// MARK: - Table View Data Source

extension FeedTableViewController {
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


