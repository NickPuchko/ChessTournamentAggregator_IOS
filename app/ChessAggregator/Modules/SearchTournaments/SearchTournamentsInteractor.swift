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

		FirebaseRef.ref.child("Tournaments").observeSingleEvent(of: .value, with: { [weak self] snapshot in
			self?.events = EventParser.eventsFromSnapshot(snapshot: snapshot) ?? []
			self?.output?.updateView()
		})
	}
}

extension SearchTournamentsInteractor: SearchTournamentsInteractorInput {

	func refreshEvents() {
		FirebaseRef.ref.child("Tournaments").observeSingleEvent(of: .value, with: { [weak self] snapshot in
			self?.events = EventParser.eventsFromSnapshot(snapshot: snapshot) ?? []
			self?.output?.updateView()
		})
	}

	func loadSections() -> [EventSectionModel] {
		var sections: [EventSectionModel] = []
		for event in events {
			sections.append(EventSectionModel(event: event))
		}
		return sections
	}

	func count(mode: Mode) -> Int {
		let filterEvents = events.filter { $0.mode == mode}
		return filterEvents.count
	}

	func count() -> Int {
		events.count
	}
}
