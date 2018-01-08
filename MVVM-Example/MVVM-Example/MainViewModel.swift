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

class MainViewModel {
    
    let testFireBase = TestFireBase()

    let text = Variable<String?>("")
    let buttonTap = PublishSubject<Void>()

    lazy var isButtonEnable: Observable<Bool> = {
        return self.text.asObservable()
            .map {!$0!.isEmpty}
            .share(replay: 1)
    }()

    lazy var buttonTapObsarvable: Observable<Void> = {
        
        return self.buttonTap.asObservable()
            .map { [unowned self] _  in
               self.testFireBase.setValue(value:self.text.value ?? "")
            }
            .share(replay: 1)
    }()
    

    init() {
    }
    
}
