//
//  ManagerContainer.swift
//  ChessAggregator
//
//  Created by Administrator on 03.02.2021.
//  
//

import UIKit

final class ManagerContainer {
    let input: ManagerModuleInput
	let viewController: UIViewController
	private(set) weak var router: ManagerRouterInput!

	static func assemble(with context: ManagerContext) -> ManagerContainer {
        let router = ManagerRouter()
        let interactor = ManagerInteractor(tournament: context.event)
        let presenter = ManagerPresenter(router: router, interactor: interactor)
		let viewController = ManagerViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

		router.interactor = interactor
		router.navigationControllerProvider = { [weak viewController] in
			viewController?.navigationController
		}

        return ManagerContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ManagerModuleInput, router: ManagerRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ManagerContext {
	weak var moduleOutput: ManagerModuleOutput?
	var event: Tournament
}
