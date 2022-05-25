//
//  AppCoordinator.swift
//  Urban Cribs
//
//  Created by Edwin Weru on 05/05/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    private var logoutObserver: NSObjectProtocol?

    override func start() {
        goToSplash()
    }

    private func goToApp() {
    }

    private func forceLogout(_ coordinator: Coordinator) {
        navigationController?.dismiss(animated: true) {
            coordinator.finishWorkflow()
            self.goToApp()
        }
    }

    private func goToSplash() {
        //let splashScreen = SplashViewController()
        //splashScreen.goToApp = goToApp

        //push(viewController: splashScreen)
    }
}
