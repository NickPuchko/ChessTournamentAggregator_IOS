//
//  TournamentsModuleContainer.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import UIKit

final class TournamentsModuleContainer {
    let input: TournamentsModuleModuleInput
	let viewController: UIViewController
	private(set) weak var router: TournamentsModuleRouterInput!

	static func assemble(with context: TournamentsModuleContext) -> TournamentsModuleContainer {
        let router = TournamentsModuleRouter()
        let interactor = TournamentsModuleInteractor()
        let presenter = TournamentsModulePresenter(router: router, interactor: interactor)
		let viewController = TournamentsModuleViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TournamentsModuleContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TournamentsModuleModuleInput, router: TournamentsModuleRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TournamentsModuleContext {
	weak var moduleOutput: TournamentsModuleModuleOutput?
}
