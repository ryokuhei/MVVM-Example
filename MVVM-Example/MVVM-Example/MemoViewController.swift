//
//  ViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/06.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import KRActivityIndicatorView
import KRProgressHUD

class MemoViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var memoText: UITextView!

    var viewModel = MemoViewModel(memo: Memo())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItemView = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightItemView
        
        self.binding()

    }
    
    func binding() {
        self.viewModel.memoTitle.asDriver()
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.memoText.asDriver()
            .drive(memoText.rx.text)
            .disposed(by: disposeBag)
        
        let saveTap = self.navigationItem.rightBarButtonItem?.rx.tap
        saveTap?.bind(to: self.viewModel.tapButton)
        .disposed(by: self.disposeBag)

        self.viewModel.savingObservable.subscribe(onNext: {
            result in
            
            switch result {
            case .success(let message):
                print(message)
                KRProgressHUD.showSuccess(withMessage: message)
                
            case .failure(_):
                KRProgressHUD.showError()
            }
        }).disposed(by: disposeBag)
        
        let memoTextObserbable = self.memoText.rx.text
        memoTextObserbable.bind(to: self.viewModel.memoText)
            .disposed(by: disposeBag)
    }
}
