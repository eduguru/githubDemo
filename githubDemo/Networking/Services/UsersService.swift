//
//  UsersService.swift
//  githubDemo
//
//  Created by Edwin Weru on 25/05/2022.
//

import Moya
import RxCocoa
import RxSwift

protocol UsersServiceImpl {
    func searchUsers(searchText: String, page: Int) -> Observable<UserResponse>
}

final class UsersService: UsersServiceImpl {
    
    func searchUsers(searchText: String, page: Int) -> Observable<UserResponse> {
        let provider = MoyaProvider<UsersApi>()
        
        return Observable<UserResponse>.create({ observer in
            
            provider.request(.searchUsers(searchText: searchText, page: page)) { result in
                switch result {
                case .success(let response):
                 
                    let data: String = String(data: response.data, encoding: .utf8) ?? ""
                    print(data)
                    let decoder = JSONDecoder()
                    let jsonData: Data = Data(data.utf8)
                    
                    do {
                        let responseObject = try decoder.decode(UserResponse.self, from: jsonData)
                        
                        observer.onNext(responseObject)
                        observer.onCompleted()
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        })
    }
}
