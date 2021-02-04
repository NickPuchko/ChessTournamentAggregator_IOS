//
//  MyEventsRouter.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import UIKit

final class MyEventsRouter: BaseRouter {
}

extension MyEventsRouter: MyEventsRouterInput {
    func showManager(with event: Tournament) {
        let context = ManagerContext(moduleOutput: nil, event: event)
        let container = ManagerContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }

}
