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

        let storyboard = UIStoryboard(name: "Memo", bundle: nil)
        let vVC = storyboard.instantiateInitialViewController() as! MemoViewController

        let memo = self.viewModel.memoList.value[indexPath.row]
        let vViewModel = MemoViewModel(memo: memo)
        vVC.viewModel = vViewModel

        self.navigationController?.pushViewController(vVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteMemo(index: indexPath.row)
        }
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .normal, title: "delete", handler: {
            (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                self.viewModel.deleteMemo(index: indexPath.row)
            })

        delete.backgroundColor = .red

        let swipeAction =  UISwipeActionsConfiguration(actions: [delete])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

//        let deleteButton = UITableViewRowAction(style: .normal, title: "delete") { (action, index) in
//            print("pushed..")
//            self.viewModel.deleteMemo(index: index.row)
////            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        deleteButton.backgroundColor = .red
//        return [deleteButton]
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
}
