//
//  LocationRouter.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 14.02.2021.
//  
//

import UIKit

final class LocationRouter: BaseRouter {
}

extension LocationRouter: LocationRouterInput {
    func showSearchError() {
        let alert = UIAlertController(title: "Ошибка поиска", message: "Извините, поиск локации недоступен. Попробуйте позже.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { [weak self]_ in
            self?.viewController?.dismiss(animated: true)
        }
        alert.addAction(cancel)
        viewController?.present(alert, animated: true)
    }

}
