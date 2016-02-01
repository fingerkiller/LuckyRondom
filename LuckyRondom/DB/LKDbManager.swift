//
//  LKDbManager.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKDbManager: NSObject {
    
    static let sharedInstance = LKDbManager()

    var lkDbBase:FMDatabaseQueue?
    
    private override init() {
        
        super.init();
        let dbpath:String = self.getDbPath();
        lkDbBase = FMDatabaseQueue.init(path: dbpath);
        
        self.createTables();
        
    } // 私有化init方法
    
    
    func getDbPath()->String
    {
        let searchPathArr:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let dbpath:String = searchPathArr.lastObject as! String
        
        return dbpath.stringByAppendingString("/lucky.db")
    }
    
    
    func createTables()
    {
        lkDbBase?.inDatabase({ (dbbase:FMDatabase!) -> Void in
            
            dbbase.setKey("feixue")
            
            try!dbbase.executeUpdate("create table if not exists Bucket (BucketID TEXT  NOT NULL, MyAccountID TEXT,BucketName TEXT, BucketHeaderPath TEXT,BucketResultNum INTEGER, PRIMARY KEY(BucketID,MyAccountID))", values: [])
            
            try!dbbase.executeUpdate("create table if not exists Candy (CandyID TEXT  NOT NULL,BucketID TEXT  NOT NULL, MyAccountID TEXT,CandyName TEXT, CandyimagePath TEXT, PRIMARY KEY(CandyID,MyAccountID))", values: [])
            
        })
    }
    
    
}
