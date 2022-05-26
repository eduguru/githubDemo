//
//  UsersApi.swift
//  githubDemo
//
//  Created by Edwin Weru on 25/05/2022.
//

import Moya

enum UsersApi {
    case searchUsers(searchText: String, page: Int)
}

extension UsersApi: TargetType {
    var baseURL: URL {
        switch self {
        case .searchUsers(_ , _):
            let url: URL = URL(string: "https://api.github.com/")!
            return url
        }
    }
    
    var path: String {
        switch self {
        case .searchUsers(_ , _):
            return "search/users"
        }
    }
    
    var method: Method {
        switch self {
        case .searchUsers(_ , _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchUsers(let searchText, let page):
            
            let params : [String: Any] = [
                "q": searchText,
                "page": page,
                "per_page": 100
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .searchUsers(_ , _):
            let headers: [String: String] = [
                "x-access-token": "api_key"
            ]
            return headers
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
