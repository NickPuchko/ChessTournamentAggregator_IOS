//
//  SearchTournamentsRouter.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import UIKit
import SafariServices

final class SearchTournamentsRouter: BaseRouter {
    private let phoneNumber: String

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}

extension SearchTournamentsRouter: SearchTournamentsRouterInput {
    func showInfo(section: EventSectionModel) {
        let message = """
                      Призовой фонд: \(section.event.prizeFund) рублей
                      Взнос: \(section.event.fee) рублей
                      """
        let alert = UIAlertController(title: section.event.name, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive))
        alert.addAction(UIAlertAction(title: "Сайт турнира", style: .default) { _ in
            let websiteController = SFSafariViewController(url: section.event.url)
            self.navigationController?.present(websiteController, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Подать заявку", style: .cancel) { _ in
            //TODO: переделать вот это
//            let currentVC = CurrentViewController(ref: FirebaseRef.ref, phone: self.viewController.phone, event: section.event)
//            currentVC.tabBarItem = UITabBarItem(title: "Турнир", image: UIImage(systemName: "house"), tag: 0)
//
//            navVC?.tabBarController?.viewControllers?[0] = currentVC
//
//            self.showApply()
        })
        self.navigationController?.present(alert, animated: true)
    }

    func showApply() {
        let applyAlert = UIAlertController(title: "Заявка подана!", message: "Номер телефона: \(phoneNumber)", preferredStyle: .alert)
        self.navigationController?.present(applyAlert, animated: true) {
            applyAlert.view.superview?.isUserInteractionEnabled = true
            applyAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(
            self.didTapToDismiss)))
        }
    }

}

private extension SearchTournamentsRouter {
    @objc
    func didTapToDismiss() {
        self.navigationController?.dismiss(animated: true)
        self.navigationController?.tabBarController?.selectedIndex = 0
    }
}