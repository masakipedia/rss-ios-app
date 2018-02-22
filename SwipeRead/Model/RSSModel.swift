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
    
    var terms: [String] = []
    var explanations: [String] = []
    
    func dataCount() -> Int {
        return terms.count
    }
}

