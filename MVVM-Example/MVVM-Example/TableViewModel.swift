//
//  TableViewModel.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/02.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class TableViewModel {

    let memoList = Variable<[Memo]>([])

    let listObservable: Observable<[Memo]>

    init() {
        let memoDao = MemoDao()
        self.memoList.value = memoDao.getList()

        listObservable = memoList
           .asObservable()
    }

    func addMemo() {
        let memoDao = MemoDao()

        let memo = Memo()
        memo.id        = memoDao.newId()
        memo.memoTitle = "test \(memo.id)"

        guard memoDao.insert(memo: memo) else {
            print("failed to insert....")
            return
        }
        self.memoList.value = memoDao.getList()
    }

}
