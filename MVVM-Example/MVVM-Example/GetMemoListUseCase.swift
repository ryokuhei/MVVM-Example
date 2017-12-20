//
//  GetMemoListUseCase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/20.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

class  GetMemoListUseCase {
    
    let memoDao: MemoDao
    
    init() {
        memoDao = MemoDao()
    }
    
    func invoke() -> [Memo] {
        return memoDao.getList()
    }
    
}
