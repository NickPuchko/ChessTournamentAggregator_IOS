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

	init() {
		loadEvents()
	}
}

extension SearchTournamentsInteractor: SearchTournamentsInteractorInput {

	func refreshEvents() {
		loadEvents()
	}

	func loadEvents() {
		FirebaseRef.ref.child("Tournaments").observeSingleEvent(of: .value, with: { [weak self] snapshot in
			let events = EventParser.eventsFromSnapshot(snapshot: snapshot) ?? []
			self?.output?.updateView(with: events)
		})
	}

}
