//
//  SignUpViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/29.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import KRActivityIndicatorView
import KRProgressHUD

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var mailaddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UIButton!
    
    let viewModel: SignUpViewModelType = SignUpViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.password.isSecureTextEntry = true
        let mail = self.mailaddress.rx.text
        mail.bind(to: self.viewModel.inputs.mailAddress)
            .disposed(by: disposeBag)
        
        let pass = self.password.rx.text
        pass.bind(to: self.viewModel.inputs.password)
            .disposed(by: disposeBag)
        
        let confirmTap = self.confirm.rx.tap
        confirmTap.bind(to: self.viewModel.inputs.confirmTap)
        .disposed(by: disposeBag)
        
        self.viewModel.outpus.signUp
            .asDriver(onErrorJustReturn: .Failure(.UnknownError("unnownError......")))
            .drive(onNext: {
                [unowned self] result in
                switch result {
                case .Success:
                    KRProgressHUD.set(deadlineTime: 2.0)
                    KRProgressHUD.showSuccess(withMessage: "registered an E-Mail")
                    self.navigationController?.popViewController(animated: true)
                case .Failure(let error):
                    switch error {
                    case .UnknownError(let message):
                        KRProgressHUD.set(deadlineTime: 2.0)
                        KRProgressHUD.showError(withMessage: message)
                    }
                    
                }
                
            })
            .disposed(by: disposeBag)
        self.viewModel.outpus.isValid.bind(to: self.confirm.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
}

