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

        let mainStorybard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStorybard.instantiateInitialViewController() as! MainViewController
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)

//        let storybard2 = UIStoryboard(name: "Table", bundle: nil)
//        let tableVC = storybard2.instantiateInitialViewController() as! TableViewController
//        tableVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let tableStorybard = UIStoryboard(name: "Table", bundle: nil)
        let tableVC = tableStorybard.instantiateInitialViewController() as! TableViewController
        
        
//        let naviStorybard = UIStoryboard(name: "Navigation", bundle: nil)
//        let naviVC = naviStorybard.instantiateInitialViewController() as! NavigationViewController

        let naviVC2 = UINavigationController(rootViewController: tableVC)
        
        naviVC2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        let tabs: [UIViewController] = [mainVC, naviVC2]
        self.setViewControllers(tabs, animated: true)
        
    }

}
