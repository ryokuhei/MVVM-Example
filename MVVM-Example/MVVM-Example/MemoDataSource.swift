//
//  MemoDataSource.swift
//  MVVM-Example
//
//  Created by ryoku on 2017/12/12.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MemoDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {

    typealias Element = [Memo]
    var _itemModels: Element = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return _itemModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let element = _itemModels[indexPath.row]
        cell.textLabel?.text = element.memoTitle

        return cell
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<[Memo]>) {
        UIBindingObserver(UIElement: self) { (datasource, element) in
            datasource._itemModels = element
            tableView.reloadData()

        }
        .on(observedEvent)
    }
    
}
