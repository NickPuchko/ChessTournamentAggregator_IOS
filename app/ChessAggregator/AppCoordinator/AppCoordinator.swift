//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow
	private var authCoordinator: AuthCoordinator {
		AuthCoordinator(
			window: window,
			appCoordinator: self
		)
	}
    private var chessAppCoordinator: MainCoordinator {
        MainCoordinator(
			window: window,
			appCoordinator: self
        )
    }

    init(window: UIWindow) {
        self.window = window
    }

    func startAuthFlow() {
        authCoordinator.auth()
    }


    func startMainFlow() {
        chessAppCoordinator.startApp()
    }
}

extension AppCoordinator {
	func didLogin() {
		startMainFlow()
	}
}
