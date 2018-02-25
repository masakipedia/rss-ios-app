//
//  FeedTableViewHeader.swift
//  SwipeRead
//
//  Created by MasakiOkuno on 2018/02/24.
//  Copyright © 2018年 masaki okuno. All rights reserved.
//

import UIKit
import AlamofireImage

class FeedTableViewHeader: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    func configureHeader(with URLString: String, placeholderImage: UIImage) {
        let size = headerImageView.frame.size
        
        headerImageView.af_setImage(
            withURL: URL(string: URLString)!,
            placeholderImage: placeholderImage,
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 0),
            imageTransition: .crossDissolve(0.2)
        )
    }
}
