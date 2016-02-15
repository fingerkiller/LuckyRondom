//
//  LKCandyDao.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKCandyDao: NSObject {
    
    class func saveCandy(candy:LKCandy)
    {
        
        let existBkt:Bool = self.existCandy(candy);
        
        if(existBkt)
        {
            self.updateCandy(candy)
        }
        else
        {
            self.insertCandy(candy)
        }
        
    }
    
    
    class func existCandy(candy:LKCandy)-> Bool
    {
        
        var result:Bool = false
        
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp:FMDatabase!) -> Void in
            
            let a:FMResultSet = try!dbp.executeQuery("select * from Candy where CandyID = ?", values: [candy.ID!]);
            
            while(a.next())
            {
                result = true
            }
            
        })
        
        return result
    }
    
    class func insertCandy(candy:LKCandy)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp:FMDatabase!) -> Void in
            
            _=try?dbp.executeUpdate("insert into  Candy (BucketID,CandyID,CandyName,CandyimagePath) values (?,?,?,?)", values: [candy.bucketID!,candy.ID!,candy.name!,candy.imagePath!])
            
        })
    }
    
    class func deleteCandy(candy:LKCandy)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp:FMDatabase!) -> Void in
            
            _=try?dbp.executeUpdate("delete from Candy where CandyID = ?", values: [candy.ID!]);
            
        })
    }
    
    class func updateCandy(candy:LKCandy)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp:FMDatabase!) -> Void in
            
            _=try?dbp.executeUpdate("UPDATE Candy SET CandyName = ?,CandyimagePath=? where CandyID = ?", values: [candy.name!,candy.imagePath!,candy.ID!]);
            
        })
    }
    
    class func getAllCandys(from bucketID:String!)->NSMutableArray
    {
        
        let resultarr:NSMutableArray = NSMutableArray()
        
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp:FMDatabase!) -> Void in
            
            
            let resset:FMResultSet = try!dbp.executeQuery("select * from Candy where BucketID=? ", values: [bucketID]);
            
            while(resset.next())
            {
                let candy:LKCandy = LKCandy()
                candy.name = resset.stringForColumn("CandyName")
                candy.imagePath = resset.stringForColumn("CandyimagePath");
                candy.ID = resset.stringForColumn("CandyID");
                
                resultarr.addObject(candy)
                
            }
            
        })
        
        return resultarr
    }
}
