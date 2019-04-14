//
//  Memo.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import Foundation

class Memo
{
//    var bodyType = String()
    var password = String()
    var usedfor = String()
    var key = Int()
    
    
    init() {}
    
    init(password:String, usedfor:String)
    {
//        self.bodyType = bodyType
        self.password = password
        self.usedfor = usedfor
    }
    init(password:String, usedfor:String, key: Int)
    {
//        self.bodyType = bodyType
        self.password = password
        self.usedfor = usedfor
        self.key = key
    }
    
    func toString() -> String
    {
        return self.password + ";" + self.usedfor + ";" + String(self.key)
    }
}
