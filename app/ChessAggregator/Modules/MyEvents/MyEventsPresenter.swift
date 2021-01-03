//
//  MyEventsPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import Foundation

final class MyEventsPresenter {
	weak var view: MyEventsViewInput?
    weak var moduleOutput: MyEventsModuleOutput?
    
	private let router: MyEventsRouterInput
	private let interactor: MyEventsInteractorInput

    private var isReloading = false
    private var isNextPageLoading = false
    private var tournaments: [Tournament] = []
    
    init(router: MyEventsRouterInput, interactor: MyEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyEventsPresenter: MyEventsModuleInput {
}

extension MyEventsPresenter: MyEventsViewOutput {
    func willDisplay() {
        //
    }

    func viewDidLoad() {
        isReloading = true
        interactor.reload()
    }

}

extension MyEventsPresenter: MyEventsInteractorOutput {
    func didLoad(with event: Tournament, loadType: LoadingDataType) {
        tournaments.append(event)
        let viewModels = makeViewModels(tournaments)
    }

}

private extension MyEventsPresenter {
    func makeViewModels(_ events: [Tournament]) -> [MyEventViewModel] {
        let viewModels: [MyEventViewModel] = []
        events.map { event in
            MyEventViewModel(name: event.name,
                    image: "image",
                    tourType: event.mode.rawValue,
                    prize: String(event.prizeFund),
                    startDate: event.openDate,
                    endDate: event.closeDate,
                    location: event.location,
                    averageRating: "200",
                    participantsCount: "300")
        }
        return []
    }
}