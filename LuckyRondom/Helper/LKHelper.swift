//
//  LKHelper.swift
//  LuckyRondom
//
// addtest
//  Created by py on 16/2/16.
//  Copyright © 2016年 py. All rights reserved.
//

import Foundation

public func FilePath()->String
{
    let searchPathArr:Array = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    let dbpath:String = searchPathArr.last!
    
    let path = dbpath + "/file"
    
    if(!FileManager.default.fileExists(atPath: path))
    {
       _ = try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        
    }
    
    return path
}
