//
//  SavingMemoUseCase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/18.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

class SavingMemoUseCase {
    
    let dao: MemoDao
    
    init() {
        dao = MemoDao()
    }
    
    func invoke(memo: Memo) {
        _ = dao.update(memo: memo)
    }
}
