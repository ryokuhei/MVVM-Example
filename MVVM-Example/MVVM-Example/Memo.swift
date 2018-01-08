//
//  MemoEntity.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/10.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var memoTitle: String = ""
    @objc dynamic var memoText: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

}
