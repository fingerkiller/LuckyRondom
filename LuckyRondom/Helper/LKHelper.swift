//
//  LKHelper.swift
//  LuckyRondom
//
//  Created by py on 16/2/16.
//  Copyright © 2016年 py. All rights reserved.
//

import Foundation

public func FilePath()->String
{
    let searchPathArr:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    let dbpath:String = searchPathArr.lastObject as! String
    
    let path = dbpath.stringByAppendingString("/file")
    
    if(!NSFileManager.defaultManager().fileExistsAtPath(path))
    {
       _ = try? NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        
    }
    
    return path
}
