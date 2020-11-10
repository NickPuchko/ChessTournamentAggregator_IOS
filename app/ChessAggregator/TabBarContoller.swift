//
// Created by Administrator on 09.11.2020.
//

import Foundation
import  UIKit
import Firebase

class TabBarController: UITabBarController {
    let ref: DatabaseReference
    let phone: String

    init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let profileVC = ProfileViewController(ref: ref, phone: phone)
        let tournamentsVC = TournamentsViewController(ref: ref, phone: phone)

        let currentVC = CurrentViewController(ref: ref, phone: phone)

        currentVC.tabBarItem = UITabBarItem(title: "Турнир", image: UIImage(systemName: "house"), tag: 0)
        tournamentsVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 2)

        viewControllers = [currentVC, tournamentsVC, profileVC]
    }

    var freshLaunch = true
    override func viewWillAppear(_ animated: Bool) {
        if freshLaunch == true {
            freshLaunch = false
            self.selectedIndex = 1
        }
    }
}
