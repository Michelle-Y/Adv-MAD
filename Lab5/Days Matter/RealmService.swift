//
//  RealmService.swift
//  Days Matter
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService
{
    static let share = RealmService()
    private init(){}
    
    var realm = try! Realm()
    
    func save(memo v: Memo)
    {
        do
        {
            try realm.write
            {
                realm.add(v)
            }
        } catch
        {
            print(error.localizedDescription)
        }
    }
    
    
    func delete(memo v: Memo)
    {
        do
        {
            try realm.write {
                realm.delete(v)
            }
        } catch
        {
            print(error.localizedDescription)
        }
    }
}
