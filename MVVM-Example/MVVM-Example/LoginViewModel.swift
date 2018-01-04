//  MVVM-Example
//
//  Created by ryoku on 2017/12/25.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol LoginViewModelInputs {
    var id : Variable<String?>{ get }
    var pass : Variable<String?>{ get }
    var loginTap : PublishSubject<Void>{ get }
    var signUpTap : PublishSubject<Void>{ get }
}

protocol LoginViewModelOutputs {
    var login: Observable<Result> { get }
    var gotoSignUp: Observable<Void> { get }
    var isValid: Observable<Bool> { get }
}

protocol  LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

final class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs{
    
    lazy var inputs: LoginViewModelInputs = { return self }()
    lazy var outputs: LoginViewModelOutputs = { return self }()

    let loginUseCase = LoginUseCase()
    
    let id = Variable<String?>("")
    let pass = Variable<String?>("")
    let loginTap = PublishSubject<Void>()
    let signUpTap = PublishSubject<Void>()
    
    lazy var idValid: Observable<Bool> = {
        return  self.id.asObservable()
                    .map { id -> Bool in
                        id?.count ?? 0 > 0
                    }.shareReplay(1)
        
    }()
    
    lazy var passValid: Observable<Bool> = {
        return self.pass.asObservable()
                   .map { pass ->Bool in
                       pass?.count ?? 0 > 0
                   }.shareReplay(1)
        
    }()
    
    lazy var isValid: Observable<Bool> = {
        return Observable.combineLatest(self.idValid, self.passValid) {
            (id, pass) in
            id && pass
        }.shareReplay(1)
        
    }()
    
    lazy var login: Observable<Result> = {
        return self.loginTap.asObservable()
            .flatMap {
            [unowned self] _ -> Observable<Result> in

                guard let id   = self.id.value,
                      let pass = self.pass.value else {
                        return Observable.empty()
                }
                let result = self.loginUseCase.invoke(id: id, pass: pass)

                return result
            }.shareReplay(1)
    }()
    
    lazy var gotoSignUp: Observable<Void> = {
        return self.signUpTap.asObservable()
                   .shareReplay(1)
    }()
    
    init() {
        
    }
    
}
