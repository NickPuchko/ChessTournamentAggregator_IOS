//
//  EventApplicationInteractor.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import Firebase

final class EventApplicationInteractor {
	weak var output: EventApplicationInteractorOutput?
	private let tournament: Tournament
	private let users: [User]

	init(tournament: Tournament) {
		self.tournament = tournament
		users = [] // TODO: parse participants to get average ELO and fulfill table

	}
}

extension EventApplicationInteractor: EventApplicationInteractorInput {
	func requestEvent() -> Tournament {
		tournament
	}

	func takePart() {
		let userID = Auth.auth().currentUser!.uid
		let childUpdates = ["Users/\(userID)/tournaments/\(tournament.id)": true,
							"Tournaments/\(tournament.id)/participants/\(userID)": true
		]
		FirebaseRef.ref.updateChildValues(childUpdates)
	}



}
