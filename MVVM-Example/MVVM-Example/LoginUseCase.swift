//
//  LoginUseCase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/25.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginUseCase {
    
    let firebase = AuthenticationDao()
    
    init() {
    }
    
    func invoke(id: String, pass: String) -> Observable<Result> {
        let result = firebase.loginUserWithEMail(email: id, password: pass)

        return result
    }
    
}
