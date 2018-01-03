//
//  AuthcationDao.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/29.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxCocoa
import RxSwift

class AuthenticationDao {
    
    private let resuletSubject = PublishSubject<Result>()
    lazy var result: Observable<Result> = { return self.resuletSubject }()

    
    func createUserWithEMail(email: String, password: String) ->Observable<Result> {

        Auth.auth().createUser(withEmail: email, password: password) {
            [unowned self] (user, error) in

            if let error = error {
                self.resuletSubject.onNext(.Failure(.UnknownError("\(error.localizedDescription)")))
                return
            } else {
                self.resuletSubject.onNext(.Success)
                return
            }
            
        }
        return self.result
        
    }
    
    func loginUserWithEMail(email: String, password: String) ->Observable<Result> {
        Auth.auth().signIn(withEmail: email, password: password) {
            [unowned self] (user, error) in
            if let error = error {
                self.resuletSubject.onNext(.Failure(.UnknownError("\(error.localizedDescription)")))
                return
            } else {
                self.resuletSubject.onNext(.Success)
                return
            }
        }
        
        return self.result
    }
    
}
