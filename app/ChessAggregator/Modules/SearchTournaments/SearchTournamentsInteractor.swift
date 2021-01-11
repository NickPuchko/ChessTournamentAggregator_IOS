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
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()

	init() {
		loadEvents()
	}
}

extension SearchTournamentsInteractor: SearchTournamentsInteractorInput {

	func refreshEvents() {
		loadEvents()
	}

	func loadEvents() {
		let currentDate = dateFormatter.string(from: Date())
		let userId = Auth.auth().currentUser!
		FirebaseRef.ref.child("Tournaments").queryOrdered(byChild: "participants\(userId)").queryEqual(toValue: nil).observeSingleEvent(of: .value, with: { [weak self] snapshot in
			let events = EventParser.eventsFromSnapshot(snapshot: snapshot) ?? []
			let filteredEvents = self?.filterToForthcoming(events) ?? []
			self?.output?.updateView(with: events)
		})
	}

	func filterToForthcoming(_ events: [Tournament]) -> [Tournament] {
		events.filter { $0.openDate > dateFormatter.string(from: Date()) }
	}
}
