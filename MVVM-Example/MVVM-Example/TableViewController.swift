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

        let addObservable = navigationItem.rightBarButtonItem?.rx.tap
        addObservable?.asDriver()
            .drive(onNext: { _ in
                self.addMemo()
            }).addDisposableTo(disposeBag)

        tableView.dataSource = nil
        let datasource = MemoDataSource()
        self.viewModel.listObservable.bind(to: tableView.rx.items(dataSource: datasource))
            .addDisposableTo(disposeBag)

    }

    func addMemo() {
        self.viewModel.addMemo()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memoDao = MemoDao()

        let storyboard = UIStoryboard(name: "View", bundle: nil)
        let vVC = storyboard.instantiateInitialViewController() as! ViewController

        let memo = memoDao.get(id: self.viewModel.memoList.value[indexPath.row].id)
        let vViewModel = ViewModel(memo: memo)
        vVC.viewModel = vViewModel

        self.navigationController?.pushViewController(vVC, animated: true)
    }
}
