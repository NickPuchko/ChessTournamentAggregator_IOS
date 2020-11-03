//
//  TournamentsContainer.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import UIKit

final class TournamentsContainer {
    let input: TournamentsModuleInput
	let viewController: UIViewController
	private(set) weak var router: TournamentsRouterInput!

	static func assemble(with context: TournamentsContext) -> TournamentsContainer {
        let router = TournamentsRouter()
        let interactor = TournamentsInteractor()
        let presenter = TournamentsPresenter(router: router, interactor: interactor)
		let viewController = TournamentsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TournamentsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TournamentsModuleInput, router: TournamentsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TournamentsContext {
	weak var moduleOutput: TournamentsModuleOutput?
}
