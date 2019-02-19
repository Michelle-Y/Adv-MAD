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
    var bodyType = String()
    var name = String()
    var date = String()
    
    
    init() {}
    
    init(bodyType:String, name:String, date:String)
    {
        self.bodyType = bodyType
        self.name = name
        self.date = date
    }
    
    
    func toString() -> String
    {
        return self.bodyType + ";" + self.name + ";" + self.date
    }
}
