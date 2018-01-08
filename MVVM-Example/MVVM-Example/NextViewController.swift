//
//  NextViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/11/24.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class NextViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backButton: UIButton!

    var viewModel = NextViewModel()

    let disposeBag = DisposeBag()

    override  func viewDidLoad() {
        super.viewDidLoad()
        
        // viewModel ->view
        viewModel.label.asDriver()
            .drive(self.label.rx.text)
            .disposed(by: disposeBag)

        // ButtonTap Event
        let backButton = self.backButton.rx.tap
        backButton.asDriver()
            .drive(onNext: {
                self.onBack()
            }).disposed(by: disposeBag)

    }

    func setViewModel(viewModel: NextViewModel) {
        self.viewModel = viewModel
    }

    private func onBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
