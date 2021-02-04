//
//  ManagerRouter.swift
//  ChessAggregator
//
//  Created by Administrator on 03.02.2021.
//  
//

import UIKit
import SafariServices

final class ManagerRouter: BaseRouter {
    weak var interactor: ManagerInteractor?
}

extension ManagerRouter: ManagerRouterInput {
    func showSite(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            navigationController?.present(SFSafariViewController(url: url), animated: true)
        } else {
            let alert = UIAlertController(
                    title: "Что-то пошло не так",
                    message: "Похоже, что организатор указал неверный адрес\nURL: \(url)",
                    preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel) { _ in
                alert.dismiss(animated: true)
            })
            navigationController?.present(alert, animated: true)
        }
    }

    func showMenu(event: Tournament) {
        let menu = UIAlertController(title: "Панель управления турниром", message: nil, preferredStyle: .actionSheet)
        let start = UIAlertAction(title: "Начать турнир", style: .cancel) { _ in
            print("Start!")
        }

//        let cancel = UIAlertAction(title: "Отмена", style: .cancel) //default cancel button
//        start.setValue(Styles.Color.appGreen, forKey: "titleTextColor") //might be rejected by Apple

        let abort = UIAlertAction(title: "Остановить приём заявок", style: .default) { _ in
            print("Abort!")
        }
        let edit = UIAlertAction(title: "Внести коррективы", style: .default) { [weak self] _ in
            let context = EventCreationContext(moduleOutput: nil, event: event, delegate: self?.interactor)
            let container = EventCreationContainer.assemble(with: context)
            self?.navigationController?.pushViewController(container.viewController, animated: true)
        }
        let consider = UIAlertAction(title: "Рассмотреть заявки", style: .default) { _ in
            print("Consider!")
        }
        [start, abort, edit, consider].forEach { action in
            menu.addAction(action)
        }
        navigationController?.present(menu, animated: true)
    }

}
