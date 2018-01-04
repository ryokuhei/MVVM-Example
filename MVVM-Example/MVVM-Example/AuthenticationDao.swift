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
    
    private let createResuletSubject = PublishSubject<Result>()
    lazy var createResult: Observable<Result> = { return self.createResuletSubject }()
    
    private let loginResuletSubject = PublishSubject<Result>()
    lazy var loginResult: Observable<Result> = { return self.loginResuletSubject }()
    

    
    func createUserWithEMail(email: String, password: String) ->Observable<Result> {

        Auth.auth().createUser(withEmail: email, password: password) {
            [unowned self] (user, error) in

            if let error = error {
                self.createResuletSubject.onNext(.Failure(.UnknownError("\(error.localizedDescription)")))
                return
            } else {
                self.createResuletSubject.onNext(.Success)
                return
            }
            
        }
        return self.createResult
        
    }
    
    func loginUserWithEMail(email: String, password: String) ->Observable<Result> {
        Auth.auth().signIn(withEmail: email, password: password) {
            [unowned self] (user, error) in
            if let error = error {
                print("firebase error")
                self.loginResuletSubject.onNext(.Failure(.UnknownError("\(error.localizedDescription)")))
                return
            } else {
                self.loginResuletSubject.onNext(.Success)
                return
            }
        }
        
        return self.loginResult
    }
    
}
