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

        let loginStorybard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = loginStorybard.instantiateInitialViewController() as! LoginViewController
        let loginNaviVC = UINavigationController(rootViewController: loginVC)
        loginNaviVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)

        let memoTableStorybard = UIStoryboard(name: "Table", bundle: nil)
        let memoTableVC = memoTableStorybard.instantiateInitialViewController() as! TableViewController
        let memoNaviVC = UINavigationController(rootViewController: memoTableVC)
        memoNaviVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        let tabs: [UIViewController] = [loginNaviVC, memoNaviVC]
        self.setViewControllers(tabs, animated: true)
        
        print("tab bar ")
        
    }

}
