//
//  NSObject+helper.swift
//  LuckyRondom
//
//  Created by py on 16/2/3.
//  Copyright © 2016年 py. All rights reserved.
//

import Foundation
extension NSObject
{
    
    class func randomID()->String
    {
       return NSUUID().UUIDString;
        
    }
    
}