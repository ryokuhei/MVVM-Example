//
//  SignUpViewModel.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/29.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SignUpViewModelInputs {
    var mailAddress: Variable<String?> { get }
    var password: Variable<String?> { get }
    var confirmTap: Variable<Void> { get }
}

protocol SignUpViewModelOutputs {
    var signUp: Observable<Result> { get }
}

protocol SignUpViewModelType {
    
    var inputs: SignUpViewModelInputs { get }
    var outpus: SignUpViewModelOutputs { get }
    
}

class SignUpViewModel: SignUpViewModelType, SignUpViewModelInputs, SignUpViewModelOutputs {
    
    let signUpUseCase = SignUpUseCase()
    
    lazy var inputs: SignUpViewModelInputs = { return self }()
    lazy var outpus: SignUpViewModelOutputs = { return self }()
    
    var mailAddress = Variable<String?>("")
    var password = Variable<String?>("")
    var confirmTap = Variable<Void>()
    
    lazy var signUp: Observable<Result> = {
        return self.confirmTap.asObservable()
                   .skip(1)
                   .flatMap { _ -> Observable<Result> in
                    
                        guard let email = self.mailAddress.value else {
                            let result = Result.Failure(.UnknownError("An Email has not been entered."))
                            return Observable.just(result)
                        }
                        guard let password = self.password.value else {
                            let result = Result.Failure(.UnknownError("An Password has not been entered."))
                            return Observable.just(result)
                        }
                            
                        return self.signUpUseCase.invoke(email: email, password: password)
                    }

    }()

    init() {
    }
}
