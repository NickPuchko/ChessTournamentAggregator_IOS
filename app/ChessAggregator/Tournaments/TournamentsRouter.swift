//
// Created by Administrator on 05.11.2020.
//

import UIKit
import SafariServices

class TournamentsRouter: TournamentsRouterProtocol {
    weak var viewController: TournamentsViewController!

    init(VC: TournamentsViewController) {
        self.viewController = VC
    }

    func showApply() {
        let applyAlert = UIAlertController(title: "Заявка подана!", message: "Номер телефона: \(currentUserPhone())", preferredStyle: .alert)
        viewController.present(applyAlert, animated: true) {
            applyAlert.view.superview?.isUserInteractionEnabled = true
            applyAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(
            self.didTapToDismiss)))
        }
    }

    func showInfo(section: EventSectionModel) {
        let message = """
                      Временной контроль: \(section.event.timeControl)
                      Призовой фонд: \(section.event.prizeFund) рублей
                      Взнос: \(section.event.fee) рублей
                      """
        let alert = UIAlertController(title: section.event.name, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive))
        alert.addAction(UIAlertAction(title: "Сайт турнира", style: .default) { _ in
            let websiteController = SFSafariViewController(url: section.event.url)
            self.viewController.present(websiteController, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Подать заявку", style: .cancel) { _ in
            self.showApply()
        })
        viewController.present(alert, animated: true)
    }

    @objc
    func didTapToDismiss() {
        viewController.dismiss(animated: true)
    }

}
