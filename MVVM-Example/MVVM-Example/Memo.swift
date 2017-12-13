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
    dynamic var id: Int = 0
    dynamic var memoTitle: String = ""
    dynamic var memoText: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

}
