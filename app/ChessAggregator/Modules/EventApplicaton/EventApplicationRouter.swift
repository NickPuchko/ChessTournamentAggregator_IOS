//
//  EventApplicationRouter.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import UIKit
import SafariServices

final class EventApplicationRouter: BaseRouter {
}

extension EventApplicationRouter: EventApplicationRouterInput {
    func showCancel() {
        showResult(message: "Заявка успешно отменена")
    }

    func showApply() {
        showResult(message: "Заявка успешно подана")
    }

    func showResult(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Отлично!", style: .cancel, handler: {
            action in
            alert.dismiss(animated: true)
        }))
        navigationController?.present(alert, animated: true)
    }

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
}
