//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

class AppCoordinator {

    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()

    init(window: UIWindow) {
        self.window = window
        self.setupAppearance()
    }

    func auth() {
        let context = AuthContext(moduleOutput: self)
        let container = AuthContainer.assemble(with: context)
        let navVC = UINavigationController(rootViewController: container.viewController)
        self.window.rootViewController = navVC
        self.window.makeKeyAndVisible()
    }

    func start() {
        self.setupSearch()
        self.setupProfile()
        self.setupTournament()
    }

}

extension AppCoordinator: AuthModuleOutput {
    func didLogin() {
        start()
    }
}

private extension AppCoordinator {
    func setupTournament() {
        guard let navController = self.navigationControllers[.currentTournaments] else {
            fatalError("wtf no Current")
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemYellow
        navController.setViewControllers([viewController], animated: false)
        viewController.navigationItem.title = NavControllerType.currentTournaments.title
    }

    func setupSearch() {
        guard let navController = self.navigationControllers[.search] else {
            fatalError("wtf no Search")
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        navController.setViewControllers([viewController], animated: false)
        viewController.navigationItem.title = NavControllerType.search.title
    }
    
    func setupProfile() {
        guard let navController = self.navigationControllers[.profile] else {
            fatalError("wtf no Profile")
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .brown
        navController.setViewControllers([viewController], animated: false)
        viewController.navigationItem.title = NavControllerType.profile.title
    }

    func setupAppearance() {

    }

    static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: navControllerKey.title,
                    image: navControllerKey.image,
                    tag: navControllerKey.rawValue)
            navigationController.tabBarItem = tabBarItem
            navigationController.navigationBar.prefersLargeTitles = true
            result[navControllerKey] = navigationController
        }
        return result
    }
}


fileprivate enum NavControllerType: Int, CaseIterable {
    case currentTournaments, search, profile

    var title: String {
        switch self {
        case .currentTournaments:
            return Localization.currentTournaments
        case .search:
            return Localization.search
        case .profile:
            return Localization.profile
        }
    }

    var image: UIImage? {
        switch self {
        case .currentTournaments:
            return UIImage(named: "prize")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .profile:
            return UIImage(systemName: "person")
        }
    }
}


enum Localization {
    static let currentTournaments = "Текущие турниры"
    static let search = "Поиск"
    static let profile = "Профиль"
}