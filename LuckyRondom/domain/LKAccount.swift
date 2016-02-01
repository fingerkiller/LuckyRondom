//
//  LKAccount.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKAccount: NSObject {
    
    static let currentAccount:LKAccount = LKAccount()
    
    var ID:String!
    
    private override init() {
        super.init()
        self.ID = "abcdefg"
        
    }
    
    
    
    
    
}
