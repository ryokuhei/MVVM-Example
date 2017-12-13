//
//  TabBarViewController.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/06.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storybard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storybard.instantiateInitialViewController() as! MainViewController
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)

//        let storybard2 = UIStoryboard(name: "Table", bundle: nil)
//        let tableVC = storybard2.instantiateInitialViewController() as! TableViewController
//        tableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let storybard2 = UIStoryboard(name: "Navigation", bundle: nil)
        let tableVC = storybard2.instantiateInitialViewController() as! NavigationViewController
        tableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let tabs: [UIViewController] = [mainVC, tableVC]
        self.setViewControllers(tabs, animated: true)

    }

}
