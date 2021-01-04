//
//  MyEventsInteractor.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import Firebase

final class MyEventsInteractor {
	weak var output: MyEventsInteractorOutput?

	private var events: [Tournament]?
	private var userId: String

	private var page = Constants.initialPage

	private var currentEvents: [Tournament] = []

	init() {
		userId = Auth.auth().currentUser!.uid
	}
}

extension MyEventsInteractor: MyEventsInteractorInput {
	func reload() {
		let userTourRef = FirebaseRef.ref.child("UserTournaments/\(userId)")
		let currentDate = Date() //TODO: check city for current date
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.dateFormat = "yyyy-MM-dd"
		dateFormatter.locale = Locale(identifier: "ru_RU")
		userTourRef.queryOrdered(byChild: "closeDate").queryStarting(atValue: dateFormatter.string(from: currentDate))
				.observeSingleEvent(of: .value) { [weak self] (snapshot) in
					let currentEventsDict = snapshot.value as? [String: Any] ?? [:]
					for (key, _) in currentEventsDict {
						FirebaseRef.ref.child("Tournaments").child(key)
								.observeSingleEvent(of: .value) { (snapshot) in
						}
					}

		}
	}

}

private extension MyEventsInteractor {
	func loadCurrent() -> [Tournament] {
		var result: [Tournament] = []

		return result
	}

	func createTestEvents() -> [Tournament] {
		var result: [Tournament] = []
//		result.append(Tournament(openDate: ))
		return result
	}
}

private enum Constants {
	static let initialPage = 1
}