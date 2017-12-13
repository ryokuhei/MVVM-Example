//
//  ViewModel.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/11/24.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ViewModel {

    let disposeBag = DisposeBag()

    let saveButtonTap = Variable<Void>()

    let id = Variable<Int?>(nil)
    let memoTitle = Variable<String?>("")
    let memoText  = Variable<String?>("")

    var memoObserbable: Observable<Memo> {
        return Observable
                   .combineLatest(id.asObservable(), memoTitle.asObservable(), memoText.asObservable()) {(id, title, text) in

        print("[memoO]")
        print("title: \(title!)")
        print("text: \(text!)")

                    let memo = Memo()
                    if let id = id,
                        let title = title,
                        let text = text {
                        memo.id = id
                        memo.memoTitle = title
                        memo.memoText  = text
                    }

                      return memo
                   }
        .shareReplay(1)

    }

    var savingObsavable: Observable<Memo> {
//        return saveButtonTap.asObservable().withLatestFrom(memoObserbable)

        return memoObserbable.sample(saveButtonTap.asObservable())
            .skip(1)
        .shareReplay(1)
    }

    init(memo: Memo) {
        id.value        = memo.id
        memoTitle.value = memo.memoTitle
        memoText.value  = memo.memoText
    }

    func saveMemo(memo: Memo) {
        print("[updating]")
        let memoDao = MemoDao()
        guard memoDao.update(memo: memo) else {
           return
        }

        print("id: \(memo.id)")
        print("title: \(memo.memoTitle)")
        print("text: \(memo.memoText)")
        print("upload success!!")

        self.memoTitle.value = memo.memoTitle
        self.memoText.value  = memo.memoText

    }
}
