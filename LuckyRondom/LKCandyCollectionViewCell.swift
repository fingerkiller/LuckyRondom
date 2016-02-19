//
//  LKCandyCollectionViewCell.swift
//  LuckyRondom
//
//  Created by py on 16/2/15.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKCandyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bkImage:UIImageView!
    @IBOutlet var titleLb:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let screenbounce  = UIScreen.mainScreen().bounds
        
        self.bounds = CGRectMake(0, 0, (screenbounce.size.width-40)/3, (screenbounce.size.width-40)/3)
    }

}
