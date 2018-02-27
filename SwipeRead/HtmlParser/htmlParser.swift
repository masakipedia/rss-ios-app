//
//  htmlParser.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/27.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import Foundation

class HtmlParser {
    
    func getImageURLFromString(str: String) -> String {
        if let range = str.range(of: "src=\"") {
            var src = str[range.upperBound..<str.endIndex]
            src = src[src.startIndex..<src.index(of: "\"")!]
            return String(src)
        }
        return ""
    }

    func insertImgWidth(str: String) -> (String, Bool) {
        var string = str
        if let range = str.range(of: "<img") {
            let imgToEnd = str[range.upperBound..<str.endIndex]
            string.insert(contentsOf: " width=\"100%\"", at: imgToEnd.index(of: ">")!)
            return (string, true)
        }
        return (string, false)
    }

}
