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
    let searchPathArr:NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    let dbpath:String = searchPathArr.lastObject as! String
    
    let path = dbpath + "/file"
    
    if(!FileManager.default.fileExists(atPath: path))
    {
       _ = try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        
    }
    
    return path
}
