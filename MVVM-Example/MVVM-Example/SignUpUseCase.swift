//
//  SignUpUseCase.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/29.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SignUpUseCase: UseCase {
    
    let authDao = AuthenticationDao()
    
    init() {
    }
    
    func invoke(email: String, password: String) -> Observable<Result> {
        let result = authDao.createUserWithEMail(email: email, password: password)

        return result
    }
}
