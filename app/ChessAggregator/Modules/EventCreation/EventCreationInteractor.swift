//
//  EventCreationInteractor.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import Foundation

final class EventCreationInteractor {
	weak var output: EventCreationInteractorOutput?
}

extension EventCreationInteractor: EventCreationInteractorInput {
	func saveEvent() {
		let event = initEvent()
		let tournament =
				["date" : event.date,
				 "fee" : event.fee,
				 "location" : event.location,
				 "mode" : event.mode.rawValue,
				 "prizeFund" : event.prizeFund,
				 "ratingType" : event.ratingType.rawValue,
				 "timeControl" : event.timeControl,
				 "url" : event.url.description,
				 "name" : event.name
				] as [String: Any]

		guard let key = FirebaseRef.ref.child("Tournaments").childByAutoId().key else {
			print("No auto id!")
			return
		}
		let childUpdates = ["/Tournaments/\(key)" : tournament]
		FirebaseRef.ref.updateChildValues(childUpdates)
	}
}

extension EventCreationInteractor {
	private func initEvent() -> Tournament {
		Tournament(id: "5", name: "Moscow open",
				date: "10.02.2021", location: "Moscow",
				ratingType: .fide, prizeFund: 2000000,
				fee: 5000, url: URL(string: "https://ru.wikipedia.org/wiki/Moscow_Chess_Open")!)
	}
}
