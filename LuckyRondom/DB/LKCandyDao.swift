//
//  LKCandyDao.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKCandyDao: NSObject {
    
    class func saveCandy(_ candy:LKCandy)
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
    
    
    class func existCandy(_ candy:LKCandy)-> Bool
    {
        
        var result:Bool = false
        
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            let a:FMResultSet = try!dbp!.executeQuery("select * from Candy where CandyID = ?", values: [candy.ID!]);
            
            while(a.next())
            {
                result = true
            }
            
        })
        
        return result
    }
    
    class func insertCandy(_ candy:LKCandy)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            _=try?dbp!.executeUpdate("insert into  Candy (BucketID,CandyID,CandyName,CandyimagePath) values (?,?,?,?)", values: [candy.bucketID!,candy.ID!,candy.name!,candy.imageName])
            
        })
    }
    
    class func deleteCandy(_ candy:LKCandy)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            _=try?dbp!.executeUpdate("delete from Candy where CandyID = ?", values: [candy.ID!]);
            
        })
    }
    
    class func deleteAllCandys(from bucketID:String)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            _=try?dbp!.executeUpdate("delete from Candy where BucketID = ?", values: [bucketID]);
            
        })
    }
    
    
    class func updateCandy(_ candy:LKCandy)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            _=try?dbp!.executeUpdate("UPDATE Candy SET CandyName = ?,CandyimagePath=? where CandyID = ?", values: [candy.name!,candy.imageName,candy.ID!]);
            
        })
    }
    
    
    class func getAllCandys(from bucketID:String!)->NSMutableArray
    {
        
        let resultarr:NSMutableArray = NSMutableArray()
        
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            
            let resset:FMResultSet = try!dbp!.executeQuery("select * from Candy where BucketID=? ", values: [bucketID]);
            
            while(resset.next())
            {
                let candy:LKCandy = LKCandy()
                candy.name = resset.string(forColumn: "CandyName")
                candy.imageName = resset.string(forColumn: "CandyimagePath");
                candy.ID = resset.string(forColumn: "CandyID");
                candy.bucketID = bucketID;
                resultarr.add(candy)
                
            }
            
        })
        
        return resultarr
    }
}
