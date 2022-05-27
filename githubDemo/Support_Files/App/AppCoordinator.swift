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
            print(search, page)
            viewModel.getUsers(search: search, page: page)
        }

        push(viewController: vc)
    }
}
