
import Foundation
import SafariServices

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: ProfileViewController!
    init(VC: ProfileViewController) {
        self.viewController = VC
    }

    func showEditor() {
        print("Edit")
    }

    func showCreator() {
        viewController.present(CreationViewController(ref: viewController.ref, phone: viewController.phone), animated: true)
    }

    func showMyEvents() {
        print("Edit")
    }

    func showStatistics() {
        print("Edit")
    }

    func showFIDE() {
        guard let id = viewController.testUser.player.fideID else {
            print("У вас не указан FIDE id. Если он существует, укажите его в профиле!")
            // TODO: Сделать алерт, если у игрока нет fide id
            return
        }
        let fideString = "https://ratings.fide.com/profile/" + String(id)
        let fideURL = URL(string: fideString) ?? URL(string: "https://vk.com/oobermensch")!
        let fideViewController = SFSafariViewController(url: fideURL)
        viewController.present(fideViewController, animated: true)
    }

    func showFRC() {
        guard let id = viewController.testUser.player.frcID else {
            print("У вас не указан ФШР id. Если он существует, укажите его в профиле!")
            return
            // TODO: Сделать алерт, если у игрока нет фшр id
        }
        let frcString = "https://ratings.ruchess.ru/people/" + String(id)
        let frcURL = URL(string: frcString) ?? URL(string: "https://vk.com/oobermensch")!
        let frcViewController = SFSafariViewController(url: frcURL)
        viewController.present(frcViewController, animated: true)
    }
}
