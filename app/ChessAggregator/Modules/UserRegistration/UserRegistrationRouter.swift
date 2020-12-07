//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import SafariServices

class UserRegistrationRouter: BaseRouter {

}

extension UserRegistrationRouter: UserRegistrationRouterInput {
    func showFide() {
        let fideUrl = URL(string: "https://ratings.fide.com/search.phtml") ?? URL(string: "https://www.google.com")!
        let fideViewController = SFSafariViewController(url: fideUrl)
        navigationController?.present(fideViewController, animated: true)
    }

    func showFrc() {
        let frcUrl = URL(string: "https://ratings.ruchess.ru") ?? URL(string: "https://www.google.com")!
        let frcViewController = SFSafariViewController(url: frcUrl)
        navigationController?.present(frcViewController, animated: true)
    }


}