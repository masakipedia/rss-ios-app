//
//  RSSModel.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/22.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

class RSSModel {
    
    // singleton
    static var shared = RSSModel()
    
    var terms: [String] = ["111", "222", "333"]
    var explanations: [String] = ["aaa", "bbb", "ccc"]
    
    func dataCount() -> Int {
        return terms.count
    }

}

