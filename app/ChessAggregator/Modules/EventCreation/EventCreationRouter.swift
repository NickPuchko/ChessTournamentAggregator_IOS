//
//  EventCreationRouter.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import UIKit
import SafariServices

final class EventCreationRouter: BaseRouter {
    
}

extension EventCreationRouter: EventCreationRouterInput {
    func showRules() {
        let url = URL(string: "https://handbook.fide.com/chapter/E012018") ?? URL(string: "https://handbook.fide.com")!
        let rulesVC = SFSafariViewController(url: url)
        navigationController?.present(rulesVC, animated: true)
    }

    func closeCreation() {
        navigationController?.popViewController(animated: true)
    }
    func showLocationSearch(){
        let context = LocationContext(moduleOutput: nil, delegate: viewController as! EventCreationViewController)
        let container = LocationContainer.assemble(with: context)
        navigationController?.present(container.viewController, animated: true)
    }
}
