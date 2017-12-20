//
//  DeleteMemoUseCase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/20.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

class DeleteMemoUseCase {
    
    let memoDao: MemoDao
    
    init() {
        memoDao = MemoDao()
    }
    
    func ivoke(id: Int) {

        let memo = memoDao.get(id: id)
        memoDao.delete(memo: memo)

    }
}
