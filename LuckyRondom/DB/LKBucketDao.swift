//
//  LKBucketDao.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKBucketDao: NSObject {

    class func saveBucket(_ bucket:LkBucket)
    {
        
        let existBkt:Bool = self.existBucket(bucket);
        
        if(existBkt)
        {
            self.updateBucket(bucket)
        }
        else
        {
            self.insertBucket(bucket)
        }
        
    }
    
    
    class func existBucket(_ bucket:LkBucket)-> Bool
    {
        
        var result:Bool = false
        
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) in
            let a:FMResultSet = try!dbp!.executeQuery("select * from Bucket where BucketID = ?", values: [bucket.ID!]);
            
            while(a.next())
            {
                result = true
            }
        })
        
//        dbq.lkDbBaseq?.inDatabase({ (dbp:FMDatabase!) -> Void in
//            
//            let a:FMResultSet = try!dbp.executeQuery("select * from Bucket where BucketID = ?", values: [bucket.ID!]);
//            
//            while(a.next())
//            {
//                result = true
//            }
//            
//        })
        
        return result
    }
    
    class func insertBucket(_ bucket:LkBucket)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        let userid:String = LKAccount.currentAccount.ID
        dbq.lkDbBaseq?.inDatabase({ (dbp)  in
            
            _=try?dbp!.executeUpdate("insert into  Bucket (BucketID,MyAccountID,BucketName,BucketHeaderPath,BucketResultNum) values (?,?,?,?,?)", values: [bucket.ID!,userid,bucket.title!,bucket.headerFileName!,bucket.resultNum])
            
        })
    }
    
    class func deleteBucket(_ bucket:LkBucket)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            _=try?dbp!.executeUpdate("delete from Bucket where BucketID = ?", values: [bucket.ID!]);
            
        })
    }
    
    class func updateBucket(_ bucket:LkBucket)
    {
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            _=try?dbp!.executeUpdate("UPDATE Bucket SET BucketName = ?,BucketHeaderPath=?,BucketResultNum=? where BucketID = ?", values: [bucket.title!,bucket.headerFileName!,bucket.resultNum,bucket.ID!]);
            
        })
    }
    
    class func getAllBuckets()->Array<LkBucket>
    {
        
        var resultarr:Array<LkBucket> = Array()
        
        let dbq:LKDbManager = LKDbManager.sharedInstance;
        
        dbq.lkDbBaseq?.inDatabase({ (dbp) -> Void in
            
            let userid:String = LKAccount.currentAccount.ID
            
            let resset:FMResultSet = try!dbp!.executeQuery("select * from Bucket where MyAccountID=? ", values: [userid]);
            
            while(resset.next())
            {
                let backet:LkBucket = LkBucket()
                
                backet.title = resset.string(forColumn: "BucketName")
                backet.ID = resset.string(forColumn: "BucketID")
                backet.headerFileName = resset.string(forColumn: "BucketHeaderPath")
                backet.resultNum = Int(resset.int(forColumn: "BucketResultNum"))
                
                resultarr.append(backet)
                
            }
            
        })
        
        return resultarr
    }
}
