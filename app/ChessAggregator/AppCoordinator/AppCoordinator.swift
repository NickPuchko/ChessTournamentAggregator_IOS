//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

class AppCoordinator {

    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    private var phoneNumber: String?
    private var user: User?

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

        let navigationControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        self.tabBarController.setViewControllers(navigationControllers, animated: true)
        self.window.rootViewController = tabBarController
        self.window.makeKeyAndVisible()
    }

}

extension AppCoordinator: AuthModuleOutput {
    func didLogin() {
        start()
    }

    func setPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
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
        let context = SearchTournamentsContext(moduleOutput: nil, phoneNumber: self.phoneNumber!)
        let container = SearchTournamentsContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.search.title
    }
    
    func setupProfile() {
        guard let navController = self.navigationControllers[.profile] else {
            fatalError("wtf no Profile")
        }
        let context = UserProfileContext(moduleOutput: nil, phoneNumber: self.phoneNumber!)
        let container = UserProfileContainer.assemble(with: context)
        navController.setViewControllers([container.viewController], animated: false)
        container.viewController.navigationItem.title = NavControllerType.profile.title
    }

    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white

            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = false
        }
        UINavigationBar.appearance().shadowImage = UIImage()

        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = Styles.Color.appGreen
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
            return UIImage(systemName: "house")
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