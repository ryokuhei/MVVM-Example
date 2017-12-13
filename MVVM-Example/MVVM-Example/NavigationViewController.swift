//
//  NavigationViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/06.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let storyboard = UIStoryboard(name: "Table", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController() as! TableViewController
        let navigationVC = UINavigationController(rootViewController: rootVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
}
