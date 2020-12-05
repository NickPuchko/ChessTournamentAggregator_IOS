//
//  EventCreationRouter.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import UIKit

final class EventCreationRouter: BaseRouter {

}

extension EventCreationRouter: EventCreationRouterInput {
    func closeCreation() {
        navigationController?.popToRootViewController(animated: true)
    }
}
