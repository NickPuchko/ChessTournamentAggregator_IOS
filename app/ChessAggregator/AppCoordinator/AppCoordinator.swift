//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

final class AppCoordinator {

    private let window: UIWindow
    //TODO: номер телефона
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
        self.chessAppCoordinator = ChessAppCoordinator(window: self.window, appCoordinator: self)  //TODO: номер телефона
        self.chessAppCoordinator?.startApp()

    }

}

extension AppCoordinator: AuthCoordinatorModuleOutput {
      //TODO: номер телефона

    func didLogin() {
        startApp()
    }

}

extension AppCoordinator: ChessAppCoordinatorModuleOutput {

}
