//
//  UsersViewController.swift
//  githubDemo
//
//  Created by Edwin Weru on 25/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    
    var coordinator: AppCoordinator?
    private var disposeBag = DisposeBag()
    
    private var arrayList = BehaviorSubject(value: [UserModel]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //searchBar.delegate = self
        
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                //self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                print("we do query \(query)")
                
                getUsers(search: query)
                self.tableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
    }

}

extension UsersViewController {
    private func getUsers (search: String, page: Int = 1) {
        UsersService().searchUsers(searchText: search, page: page)
            .subscribe(onNext: { response in
                let array = response.items.map({
                    UserModel(model: $0)
                })
                self.arrayList.on(.next(array))
                print("and we also got a count of \(self.arrayList)")
                
            }, onError: {error in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            .disposed(by: disposeBag)
    }
}

extension UsersViewController: UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = false;
        print(searchText)
    }
}
