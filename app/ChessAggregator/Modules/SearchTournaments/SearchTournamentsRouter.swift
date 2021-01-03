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
            let context = EventApplicationContext(moduleOutput: nil, tournament: section.event)
            let container = EventApplicationContainer.assemble(with: context)
            self.navigationController?.pushViewController(container.viewController, animated: false)
        })
        navigationController?.present(alert, animated: true)
    }

    func showApply() {
        let applyAlert = UIAlertController(title: "Заявка подана!", message: "Номер телефона: \(phoneNumber)", preferredStyle: .alert)
        navigationController?.present(applyAlert, animated: true) {
            applyAlert.view.superview?.isUserInteractionEnabled = true
            applyAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(
            self.didTapToDismiss)))
        }
    }

}

private extension SearchTournamentsRouter {
    @objc
    func didTapToDismiss() {
        navigationController?.dismiss(animated: true)
        navigationController?.tabBarController?.selectedIndex = 0
    }
}