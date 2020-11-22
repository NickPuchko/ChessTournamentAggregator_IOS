//
//  SearchTournamentsInteractor.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import Foundation
import Firebase

final class SearchTournamentsInteractor {
	weak var output: SearchTournamentsInteractorOutput?
	private let phoneNumber: String
	var events: [Tournament]

	init(phoneNumber: String) {
		self.phoneNumber = phoneNumber
		events = []
	}
}

extension SearchTournamentsInteractor: SearchTournamentsInteractorInput {
	func loadEventsFromFirebase() -> [Tournament] {
		let events: [Tournament] = []


		// TODO: Написить метод загрузки всех турниров из json (Realtime Database)
		return events
	}

	func count(mode: Mode) -> Int {
		let filterEvents = events.filter { $0.mode == mode}
		return filterEvents.count
	}

	func count() -> Int {
		events.count
	}
}
