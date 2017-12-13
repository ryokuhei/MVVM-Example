//
//  MainViewModel.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/11/24.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct MainViewModel {

    var text = Variable<String?>("")

    var isButtonEnable: Observable<Bool> {
        return text.asObservable()
            .map {!$0!.isEmpty}
    }

    init() {
    }
}
