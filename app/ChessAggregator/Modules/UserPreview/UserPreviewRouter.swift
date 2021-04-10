//
//  UserPreviewRouter.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 03.03.2021.
//  
//

import UIKit
import SafariServices

final class UserPreviewRouter: BaseRouter {
    weak var presenter: UserPreviewPresenter!
}

extension UserPreviewRouter: UserPreviewRouterInput {
    func showFIDE(user: User) {
        guard let id = user.player.fideID else {
            print("У вас не указан FIDE id. Если он существует, укажите его в профиле!")
            // TODO: Сделать алерт, если у игрока нет fide id
            return
        }
        let fideString = "https://ratings.fide.com/profile/" + String(id)
        let fideURL = URL(string: fideString) ?? URL(string: "https://vk.com/oobermensch")!
        let fideViewController = SFSafariViewController(url: fideURL)
        navigationController?.present(fideViewController, animated: true)
    }
    
    func showFRC(user: User) {
        print("fuck")
        guard let id = user.player.frcID else {
            print("У вас не указан ФШР id. Если он существует, укажите его в профиле!")
            return
            // TODO: Сделать алерт, если у игрока нет фшр id
        }
        let frcString = "https://ratings.ruchess.ru/people/" + String(id)
        let frcURL = URL(string: frcString) ?? URL(string: "https://vk.com/oobermensch")!
        let frcViewController = SFSafariViewController(url: frcURL)
        navigationController?.present(frcViewController, animated: true)
    }
}
