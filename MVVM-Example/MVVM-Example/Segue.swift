//
//  Segue.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/11/24.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit

enum Segue {
    case next
    case main

    var storyboard: String {
        switch self {
        case .next:
            return "Next"

        case .main:
            return "Main"
        }
    }

    func showViewController(viewModel: NextViewModel) -> NextViewController {
        let storyboard = UIStoryboard(name: self.storyboard, bundle: nil)

        var viewController = NextViewController()

        switch self {
        case .next:
            viewController = storyboard.instantiateInitialViewController() as! NextViewController
            viewController.setViewModel(viewModel: viewModel )
//            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
        return viewController
    }

    func backViewController() {
//        _ = slef.navigationController?.popViewController(animated: true)
    }
}
