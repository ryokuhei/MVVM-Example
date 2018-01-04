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
    var confirmTap: PublishSubject<Void> { get }
}

protocol SignUpViewModelOutputs {
    var signUp: Observable<Result> { get }
    var isValid: Observable<Bool> { get }
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
    var confirmTap = PublishSubject<Void>()
    

    lazy var mailValid: Observable<Bool> = {
        return self.mailAddress.asObservable()
            .map { mail -> Bool in
                mail?.count ?? 0 > 0
            }.shareReplay(1)
    }()
    
    lazy var passValid: Observable<Bool> = {
        return self.password.asObservable()
            .map { pass -> Bool in
                pass?.count ?? 0 > 0
            }.shareReplay(1)
    }()
    
    
    lazy var isValid: Observable<Bool> = {
        return Observable.combineLatest(self.mailValid, self.passValid) {
            (mail, pass) -> Bool in
            mail && pass
        }.shareReplay(1)
    }()
    
    lazy var signUp: Observable<Result> = {
        return self.confirmTap.asObservable()
                   .flatMap { [unowned self] _ -> Observable<Result> in
                    
                        guard let email = self.mailAddress.value else {
                            let result = Result.Failure(.UnknownError("An Email has not been entered."))
                            return Observable.just(result)
                                             .shareReplay(1)
                        }
                        guard let password = self.password.value else {
                            let result = Result.Failure(.UnknownError("An Password has not been entered."))
                            return Observable.just(result)
                                             .shareReplay(1)
                        }
                            
                        return self.signUpUseCase.invoke(email: email, password: password)
                    }

    }()

    init() {
    }
}
