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
        if let memo = self.realm.objects(Memo.self).last,
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

  //      let memoObject = self.realm.object(ofType: Memo.self, forPrimaryKey: memo.id)

        try! self.realm.write {

            self.realm.add(memo, update: true)
//            memoObject?.memoTitle = memo.memoTitle
 //           memoObject?.memoText  = memo.memoText

            result = true
        }

        return result
    }

    func getList() -> [Memo] {
        let result =  self.realm.objects(Memo.self)
        return Array(result)
    }

    func get(id: Int) -> Memo {

        guard let memo  = self.realm.object(ofType: Memo.self, forPrimaryKey: id) else {
            return Memo()
        }

        print("[get]")
        print("id: \(memo.id)")
        print("title: \(memo.memoTitle)")
        print("text: \(memo.memoText)")

        return memo
    }
}
