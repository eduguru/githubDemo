//
//  UsersViewController.swift
//  githubDemo
//
//  Created by Edwin Weru on 25/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: BaseViewController<UsersViewModel> {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.reUseIdentifier)
            tableView.rowHeight = 80.0
        }
    }
    
    var searchActive : Bool = false
    
    var backAction: () -> Void = {}
    var search: (String, Int) -> Void = { _, _ in }
    var didSelect: (UserModel) -> Void = { _ in }
    
    var coordinator: AppCoordinator?
    private var arrayList = BehaviorSubject(value: [UserModel]())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSearchListener()
        
        viewModel.arrayList
            .subscribe(onNext: { array in
                self.arrayList.on(.next(array))
            }, onError: {error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            .disposed(by: disposeBag)
        
        bindTableView()
    }

}

extension UsersViewController : UITableViewDelegate {
    private func addSearchListener() {
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.search(query, 1)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        arrayList.bind(
            to: tableView.rx.items( cellIdentifier: UserTableViewCell.reUseIdentifier, cellType: UserTableViewCell.self)
        ) { ( row, item, cell) in
            cell.configure(with: item)
        }
        .disposed(by: disposeBag)
    }
}
