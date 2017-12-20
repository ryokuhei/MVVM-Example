//  MVVM-Example
//
//  Created by ryoku on 2017/12/02.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TableViewController: UITableViewController {

    var viewModel = TableViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        
        self.bainding()
    }
    
    func bainding() {
        let addObservable = self.navigationItem.rightBarButtonItem?.rx.tap
        addObservable?.asDriver()
            .drive(onNext: { _ in
                self.viewModel.addMemo()
            }).addDisposableTo(disposeBag)
        
        tableView.dataSource = nil
        let datasource = MemoDataSource()
        self.viewModel.listObservable.bind(to: tableView.rx.items(dataSource: datasource))
            .addDisposableTo(disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "View", bundle: nil)
        let vVC = storyboard.instantiateInitialViewController() as! ViewController

        let memo = self.viewModel.memoList.value[indexPath.row]
        let vViewModel = ViewModel(memo: memo)
        vVC.viewModel = vViewModel

        self.navigationController?.pushViewController(vVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: .default, title: "delete") { (action, index) in
            self.viewModel.deleteMemo(index: index.row)
        }
        deleteButton.backgroundColor = .red
        return [deleteButton]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
}
