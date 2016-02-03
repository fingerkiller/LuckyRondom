//
//  LKCandy.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

public class LKCandy: NSObject {

    var bucketID:String?
    var ID:String?
    var name:String?
    var imagePath:String?
    
    override init()
    {
        super.init()
        
        self.ID = NSObject.randomID();
        self.name = ""
        self.imagePath = ""
    }
    
}
