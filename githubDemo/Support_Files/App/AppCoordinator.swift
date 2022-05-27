//
//  AppCoordinator.swift
//
//  Created by Edwin Weru
//

import UIKit

final class AppCoordinator: Coordinator {

    override func start() {
        goToApp()
    }

    private func goToApp() {
        let viewModel = UsersViewModel()
        let vc = UsersViewController(viewModel: viewModel)
        
        vc.search = { [weak self] search, page in
            viewModel.getUsers(search: search, page: page)
        }
        
        vc.didSelect = showUserDetails(_:)

        push(viewController: vc)
    }
    
    private func showUserDetails(_ selected: UserModel) {
        let viewModel = UsersViewModel()
        let vc = UserDetailsViewController(viewModel: viewModel)
        vc.selectedItem = selected
        
        push(viewController: vc)
    }
}
