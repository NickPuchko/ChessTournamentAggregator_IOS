//
//  SearchTournamentsContainer.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import UIKit

final class SearchTournamentsContainer {
    let input: SearchTournamentsModuleInput
	let viewController: UIViewController
	private(set) weak var router: SearchTournamentsRouterInput!

	static func assemble(with context: SearchTournamentsContext) -> SearchTournamentsContainer {
        let router = SearchTournamentsRouter(phoneNumber: context.phoneNumber)
        let interactor = SearchTournamentsInteractor(phoneNumber: context.phoneNumber)
        let presenter = SearchTournamentsPresenter(router: router, interactor: interactor)
		let viewController = SearchTournamentsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

		router.navigationControllerProvider = { [weak viewController] in
			viewController?.navigationController
		}

        return SearchTournamentsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: SearchTournamentsModuleInput, router: SearchTournamentsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct SearchTournamentsContext {
	weak var moduleOutput: SearchTournamentsModuleOutput?
	var phoneNumber: String
}
