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
            
            
           try!dbbase.executeUpdate("create table if not exists USER (AccountID TEXT PRIMARY KEY NOT NULL, Account TEXT(1024,0) NOT NULL,Name TEXT ,  Email TEXT , Telephone TEXT, FaceID TEXT, Signature TEXT )", values: [])
            
        })
    }
    
    
}
