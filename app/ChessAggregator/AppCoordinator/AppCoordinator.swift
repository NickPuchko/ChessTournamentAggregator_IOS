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
        authCoordinator = AuthCoordinator(window: window, appCoordinator: self)
        authCoordinator?.auth()
    }


    func startApp() {
        chessAppCoordinator = ChessAppCoordinator(window: window, phoneNumber: phoneNumber, appCoordinator: self)
        chessAppCoordinator?.startApp()
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