//
//  AddMemoUseCase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/20.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

class AddMemoUseCase {
    
    let memoDao: MemoDao

    init() {
        memoDao = MemoDao()
    }
    
    func invoke() {
        print("invoke")

        let memo = Memo()
        memo.id = memoDao.newId()
        memo.memoTitle = "title \(memo.id)"
        
        print(memo)

        guard memoDao.insert(memo: memo) else {
            print("failed to insert....")
            return
        }
    }
}
