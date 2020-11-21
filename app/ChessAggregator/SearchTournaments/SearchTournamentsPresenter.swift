//
//  SearchTournamentsPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import Foundation

final class SearchTournamentsPresenter {
	weak var view: SearchTournamentsViewInput?
    weak var moduleOutput: SearchTournamentsModuleOutput?
    
	private let router: SearchTournamentsRouterInput
	private let interactor: SearchTournamentsInteractorInput

    private var sections: [EventSectionModel]
    
    init(router: SearchTournamentsRouterInput, interactor: SearchTournamentsInteractorInput) {
        self.router = router
        self.interactor = interactor
        sections = []

        let events = createEvents()

        for event in events {
            sections.append(EventSectionModel(event: event))
        }
    }

    func createEvents() -> [Tournament] {
        // TODO: вставить сюда метод, возвращающий массив турниров
        //var events: [Tournament] = interactor.loadEventsFromFirebase()

        // TODO: когда заработают методы работы с Firebase, пренести создание этих трёх турниров отсюда в интерактор
        var events: [Tournament] = []
        let bestURL = URL(string: "https://vk.com/oobermensch")!
        events.append(Tournament(name: "HSE cup", mode: .rapid, date: "10.12.2020", location: "Москва", ratingType: "Без обсчёта рейтинга", timeControl: "15+0", prizeFund: 10000, fee: 500, url: URL(string: "https://sport.hse.ru/chess") ?? bestURL))
        events.append(Tournament(name: "Moscow open", mode: .classic, date: "18.01.2021", location: "Москва", ratingType: "FIDE", timeControl: "90+30", prizeFund: 12000000, fee: 50000, url: URL(string: "https://ruchess.ru/championship/detail/2020/aeroflot_open_2020/") ?? bestURL))
        events.append(Tournament(name: "Чемпионат России", mode: .blitz, date: "24.12.2020", location: "Сочи", ratingType: "Российский рейтинг", timeControl: "3+2", prizeFund: 2000000, fee: 25000, url: URL(string: "https://chesspro.ru/tournaments/russia_ch_higher_league20") ?? bestURL))
        return events
    }
}

extension SearchTournamentsPresenter: SearchTournamentsModuleInput {
}

extension SearchTournamentsPresenter: SearchTournamentsViewOutput {
    func showInfo(section: EventSectionModel) {
        router.showInfo(section: section)
    }

    func showApply() {
        router.showApply()
    }

    func configureView() {
        view?.loadEvents(sections)
    }

}

extension SearchTournamentsPresenter: SearchTournamentsInteractorOutput {
}
