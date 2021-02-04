//
//  MyEventsRouter.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import UIKit
import FirebaseAuth

final class MyEventsRouter: BaseRouter {
}

extension MyEventsRouter: MyEventsRouterInput {
    func showManager(with event: Tournament) {
        if event.organizerId == Auth.auth().currentUser?.uid {
            let context = ManagerContext(moduleOutput: nil, event: event)
            let container = ManagerContainer.assemble(with: context)
            navigationController?.pushViewController(container.viewController, animated: true)
        } else {
            let context = EventApplicationContext(moduleOutput: nil, tournament: event)
            let container = EventApplicationContainer.assemble(with: context)
            navigationController?.pushViewController(container.viewController, animated: true)
        }

    }

}
