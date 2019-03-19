//
//  Memo.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import Foundation
import RealmSwift
class Memo: Object
{
    @objc dynamic var bodyType = String()
    @objc dynamic var name = String()
    @objc dynamic var date = String()
    
    
//    init() {}
    
    convenience init(bodyType:String, name:String, date:String)
    {
        self.init()
        self.bodyType = bodyType
        self.name = name
        self.date = date
    }
    
    
    func toString() -> String
    {
        return self.bodyType + ";" + self.name + ";" + self.date
    }
}
