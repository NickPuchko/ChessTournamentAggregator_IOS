//
//  UserPreviewContainer.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 03.03.2021.
//  
//

import UIKit

final class UserPreviewContainer {
    let input: UserPreviewModuleInput
	let viewController: UIViewController
	private(set) weak var router: UserPreviewRouterInput!

	static func assemble(with context: UserPreviewContext) -> UserPreviewContainer {
        let router = UserPreviewRouter()
        let interactor = UserPreviewInteractor()
        let presenter = UserPreviewPresenter(router: router, interactor: interactor)
		let viewController = UserPreviewViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return UserPreviewContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: UserPreviewModuleInput, router: UserPreviewRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct UserPreviewContext {
	weak var moduleOutput: UserPreviewModuleOutput?
}
