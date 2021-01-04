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

	init(tournament: Tournament) {
		self.tournament = tournament
	}
}

extension EventApplicationInteractor: EventApplicationInteractorInput {
	func saveTourToDatabase() {
		//TODO: еще добавить запись в ветку TournamentParticipants
		let userID = Auth.auth().currentUser!.uid
		FirebaseRef.ref.child("UserTournaments/\(userID)/\(tournament.id)").setValue(["closeDate": tournament.closeDate])
	}

}
