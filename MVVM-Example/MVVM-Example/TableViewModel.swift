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
    
    private let getMemoListUseCase = GetMemoListUseCase()
    private let addMemoUseCase = AddMemoUseCase()
    private let deleteMemoUseCase = DeleteMemoUseCase()

    let memoList = Variable<[Memo]>([])

    lazy var listObservable: Observable<[Memo]> = {
        return self.memoList
            .asObservable()
            .shareReplay(1)
    }()
    
    init() {
       self.memoList.value = getMemoListUseCase.invoke()
    }

    func addMemo() {
        addMemoUseCase.invoke()
        self.memoList.value = getMemoListUseCase.invoke()
    }
    
    func deleteMemo(index: Int) {
        let id = memoList.value[index].id
        deleteMemoUseCase.ivoke(id: id)
        self.memoList.value = getMemoListUseCase.invoke()
    }

}
