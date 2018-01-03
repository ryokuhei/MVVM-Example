//
//  LoginViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/25.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import KRProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIBarButtonItem!
    

    let viewModel: ViewModelType = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pass.isSecureTextEntry = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "sign up", style: .plain, target: nil, action: nil)
        self.bind()
    }
    
    func bind() {
        // inputs
        let id = self.id.rx.text
        id.bind(to: self.viewModel.inputs.id)
            .disposed(by: disposeBag)
        
        let pass = self.pass.rx.text
        pass.bind(to: self.viewModel.inputs.pass)
            .disposed(by: disposeBag)
        
        let loginTap = self.login.rx.tap
        loginTap.bind(to: self.viewModel.inputs.loginTap)
            .disposed(by: disposeBag)
        
        let signUp = self.navigationItem.rightBarButtonItem?.rx.tap
        signUp?.bind(to: self.viewModel.inputs.signUpTap)
            .addDisposableTo(disposeBag)

        
        // outputs
        self.viewModel.outputs.login
            .asDriver(onErrorJustReturn: .Failure(.UnknownError("")))
            .drive(onNext:{ [unowned self] result in
                switch result {
                case .Success :
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateInitialViewController() as! MainViewController
                    self.present(viewController, animated: true, completion: nil)
                case .Failure(let error) :
                    switch error {
                    case .UnknownError(let message):
                        KRProgressHUD.set(deadlineTime: 2.0)
                        KRProgressHUD.showError(withMessage: message)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.gotoSignUp
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                [unowned self] _ in
                let storyBoard = UIStoryboard(name: "SignUp", bundle: nil)
                let viewController = storyBoard.instantiateInitialViewController() as! SignUpViewController
                self.navigationController?.pushViewController(viewController, animated: true)

            })
            .disposed(by: disposeBag)
    }
    
}
