//
//  MainViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/11/24.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var button: UIButton!

    let disposeBag = DisposeBag()

    var viewModel = MainViewModel()
    var nextViewModel = NextViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // view -> viewModel
        let textObservable = self.text.rx.text

        textObservable
            .bind(to: viewModel.text)
            .disposed(by: disposeBag)

//        textObservable
//            .bind(to: nextViewModel.label)
//            .disposed(by: disposeBag)
        
        let tapObsarvable = button.rx.tap
        
        tapObsarvable.bind(to: viewModel.buttonTap)
            .disposed(by: disposeBag)
        



        // viewModel -> view
        viewModel.isButtonEnable
            .asDriver(onErrorJustReturn: false)
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)

        // ButtonTap Event
        viewModel.buttonTapObsarvable
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { _ in
                self.gotoNextViewController()
            })
            .disposed(by: disposeBag)
    }

    private func gotoNextViewController() {
        let storyboard = UIStoryboard(name: "Next", bundle: nil)
        let nextViewController = storyboard.instantiateInitialViewController() as! NextViewController
        nextViewController.setViewModel(viewModel: nextViewModel)

        present(nextViewController, animated: true, completion: nil)
    }

}
