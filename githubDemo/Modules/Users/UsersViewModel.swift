//
//  UsersViewModel.swift
//  githubDemo
//
//  Created by Edwin Weru on 25/05/2022.
//

import RxSwift

class UsersViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var arrayList = BehaviorSubject(value: [UserModel]())
    
    override init() {
        super.init()
    }
    
    func getUsers (search: String, page: Int = 1) {
        UniversalLoader().showUniversalLoadingView(true)
        UsersService().searchUsers(searchText: search, page: page)
            .subscribe(onNext: { response in
                let array = response.items.map({
                    UserModel(model: $0)
                })
                self.arrayList.on(.next(array))
                UniversalLoader().showUniversalLoadingView(false)
                
            }, onError: {error in
                print(error)
                UniversalLoader().showUniversalLoadingView(false)
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            .disposed(by: disposeBag)
    }
}
