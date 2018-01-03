//  MVVM-Example
//
//  Created by ryoku on 2017/12/25.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelInputs {
    var id : Variable<String?>{ get }
    var pass : Variable<String?>{ get }
    var loginTap : Variable<Void>{ get }
    var signUpTap : Variable<Void>{ get }
}

protocol ViewModelOutputs {
    var login: Observable<Result> { get }
    var gotoSignUp: Observable<Void> { get }
}

protocol  ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

final class LoginViewModel: ViewModelType, ViewModelInputs, ViewModelOutputs{
    
    lazy var inputs: ViewModelInputs = { return self }()
    lazy var outputs: ViewModelOutputs = { return self }()

    let loginUseCase = LoginUseCase()
    
    let id = Variable<String?>("")
    let pass = Variable<String?>("")
    let loginTap = Variable<Void>()
    let signUpTap = Variable<Void>()
    
    lazy var login: Observable<Result> = {
        return self.loginTap.asObservable()
            .skip(1)
            .flatMap {
            [unowned self] _ -> Observable<Result> in

                guard let id   = self.id.value else {
                    let result = Result.Failure(.UnknownError("An Id has not been entered."))
                    return Observable.just(result)
                }
                guard let pass = self.pass.value else {
                    let result = Result.Failure(.UnknownError("An Password has not been entered."))
                    return Observable.just(result)
                }
                let result = self.loginUseCase.invoke(id: id, pass: pass)
                print("login-result : \(result)")

                return result
        }
    }()
    
    lazy var gotoSignUp: Observable<Void> = {
        return self.signUpTap.asObservable()
                   .skip(1)
    }()
    
    init() {
        
    }
    
}
