//
//  LkBucket.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LkBucket: NSObject {

    var ID:String?
    
    var name:String?//名称
    
    var headerPath:String?//图片路径
    
    var resultNum:Int?//结果数
    
    lazy var sourceCandies:NSMutableArray=NSMutableArray()//数据源
    
    var resultCandies:NSMutableArray?//结果集
    
    
    override init() {
        super.init()
        self.ID = NSObject.randomID();
        self.name = "";
        self.headerPath = "";
        self.resultNum = 1
    }
    
    
    func savetoLocal()
    {
        LKBucketDao.saveBucket(self)
        
    }
    
    
    func saveCandy(candy:LKCandy)
    {
        candy.bucketID = self.ID
        LKCandyDao.saveCandy(candy)
        
    }
    
    
    func rollCandy()
    {
        let count = self.sourceCandies.count;
        self.resultCandies = NSMutableArray()
        var rollnum = resultNum;
        while(rollnum>0)
        {
            let dex =  Int(arc4random()) % count
            
            let candy = self.sourceCandies[dex];
            
            if((self.resultCandies?.containsObject(candy)) != false)
            {
                continue
            }
            else
            {
                self.resultCandies?.addObject(candy)
                rollnum=rollnum!-1;
            }
            
        }
    }
    
}
