//
//  DateMemo.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import Foundation

class DateMemo
{
    var dateList = [Memo]()
    
    func toString() -> [String] {
        var list = [String]()
        
        for v in self.dateList
        {
            list.append(v.toString())
        }
        
    return list
    }
    
    func getIndex(memo: Memo) -> Int
    {
        var index = 0
        
        for v in self.dateList
        {
            if v.bodyType == memo.bodyType && v.name == memo.name && v.date == memo.date
           
            {
                return index
            }
            index = index + 1
        }
        return -1
    }
}
