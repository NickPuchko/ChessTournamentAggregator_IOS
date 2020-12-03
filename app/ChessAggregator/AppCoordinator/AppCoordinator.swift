//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

final class AppCoordinator {

    private let window: UIWindow
    var phoneNumber: String?
    private var authCoordinator: AuthCoordinator?
    private var chessAppCoordinator: ChessAppCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func auth() {
        self.authCoordinator = AuthCoordinator(window: self.window, appCoordinator: self)
        self.authCoordinator?.auth()
    }


    func startApp() {
        self.chessAppCoordinator = ChessAppCoordinator(window: self.window, phoneNumber: self.phoneNumber, appCoordinator: self)
        self.chessAppCoordinator?.startApp()
    }

}

extension AppCoordinator: AuthCoordinatorModuleOutput {
    func setPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

    func didLogin() {
        startApp()
    }

}

extension AppCoordinator: ChessAppCoordinatorModuleOutput {

}