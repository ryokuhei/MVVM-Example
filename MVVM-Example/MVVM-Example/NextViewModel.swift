//
//  NextViewModel.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/11/24.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class NextViewModel {
    
    let testFireBase = TestFireBase()
    
    var label = Variable<String?>("")

    init() {
        label.value = testFireBase.getValue()
    }
}
