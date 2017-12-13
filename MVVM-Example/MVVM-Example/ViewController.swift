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

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var memoText: UITextView!

    var viewModel = ViewModel(memo: Memo())
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.memoTitle.asDriver()
            .drive(label.rx.text)
            .disposed(by: disposeBag)

        self.viewModel.memoText.asDriver()
            .drive(memoText.rx.text)
            .disposed(by: disposeBag)

        let rightItemView = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightItemView

        let tap = self.navigationItem.rightBarButtonItem?.rx.tap
        tap?.asDriver().drive(viewModel.saveButtonTap)
        .disposed(by: disposeBag)

        self.viewModel.savingObsavable.subscribe(onNext: {memo in
            self.save(memo: memo)
        }).addDisposableTo(disposeBag)

        let memoTextObserbable = self.memoText.rx.text
        memoTextObserbable.bind(to: self.viewModel.memoText)
            .disposed(by: disposeBag)

    }

    private func save(memo: Memo) {
        self.viewModel.saveMemo(memo: memo)

    }
}
