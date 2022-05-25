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
        let vc = UsersViewController()

        push(viewController: vc)
    }
}
