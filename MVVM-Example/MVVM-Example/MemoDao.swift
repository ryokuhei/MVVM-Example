//
//  MemoDao.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/10.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RealmSwift

class MemoDao {

    let realm: Realm

    init() {
      print("Realm FilePath: \(Realm.Configuration.defaultConfiguration.fileURL!)")

//        let config = Realm.Configuration(readOnly: false, schemaVersion: 3, deleteRealmIfMigrationNeeded: false)
//        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true

        self.realm = try! Realm()

    }

    func newId() -> Int {

        guard let key = Memo.primaryKey() else {
            return 0
        }
        var id = 0
        if let memo = self.realm.objects(Memo.self).sorted(byKeyPath: key).last,
           let lastId = memo[key] as? Int {
            id = lastId + 1
        } else {
            id = 1
        }

        return id

    }

    func insert(memo: Memo) -> Bool {
        var result: Bool = false

        try! self.realm.write {
            self.realm.add(memo, update: true)
            result = true
        }

        return result

    }

    func update(memo: Memo) -> Bool {
        var result: Bool = false

        try! self.realm.write {

            self.realm.add(memo, update: true)

            result = true
        }

        return result
    }

    func getList() -> [Memo] {
        guard let id = Memo.primaryKey() else {
            print("undefine primaryKey...")
            return []
        }
        let result =  self.realm.objects(Memo.self).sorted(byKeyPath: id)
        return Array(result)
    }

    func get(id: Int) -> Memo {

        guard let memo  = self.realm.object(ofType: Memo.self, forPrimaryKey: id) else {
            return Memo()
        }

        return memo
    }
    
    func delete(memo: Memo) {
        
        try! realm.write {
            realm.delete(memo)
        }
    }
}
