//
//  ManagerInteractor.swift
//  ChessAggregator
//
//  Created by Administrator on 03.02.2021.
//  
//

import Foundation
import FirebaseAuth

final class ManagerInteractor {
	weak var output: ManagerInteractorOutput?
	var event: Tournament
	private var users: [User]
	private lazy var uid = Auth.auth().currentUser!.uid
	private var averageRating = 0
	private var participantsCount = 0
	private var usersSorted: [PlayerModel] = []


	init(tournament: Tournament) {
		event = tournament
		users = []

		FirebaseRef.ref.child("Users")
				.queryOrdered(byChild: "tournaments/\(event.id)").queryEqual(toValue: true)
				.observeSingleEvent(of: .value) { [weak self] (snapshot) in
					self?.users = UserParser.usersFromSnapshot(snapshot: snapshot)
					self?.reloadData()
				}
	}
}

extension ManagerInteractor: ManagerInteractorInput {
	func requestEvent() -> Tournament {
		event
	}

	func reloadData() {
		var players: [PlayerModel] = []
		var eloSum = 0
		var ratedPLayersCount = 0

		for user in users {
			let player = PlayerModel(
					name: user.player.lastName + " " + user.player.firstName,
					rating: getCurrentRating(player: user.player, ratingType: event.ratingType, mode: event.mode
					))
			players.append(player)
			if let rating = player.rating {
				eloSum += rating
				ratedPLayersCount += 1
			}
		}
		players.sort { model1, model2 in
			if let rating1 = model1.rating {
				if let rating2 = model2.rating {
					if rating1 >= rating2 {
						if rating1 == rating2 {
							return model1.name < model2.name
						} else {
							return true
						}
					} else {
						return false
					}
				} else {
					return true
				}
			} else {
				if model2.rating != nil {
					return false
				} else {
					return model1.name < model2.name
				}
			}
		}
		usersSorted = players
		participantsCount = users.count
		if ratedPLayersCount == 0 {
			output?.reloadData(players: players, elo: 0, participants: participantsCount)
		} else {
			averageRating = eloSum  / ratedPLayersCount
			output?.reloadData(players: players, elo: averageRating, participants: users.count)
		}
	}

	private func getCurrentRating(player: Player, ratingType: RatingType, mode: Mode) -> Int? {
		let rating = [
			(RatingType.fide.rawValue + Mode.fide.rawValue) : player.classicFideRating,
			(RatingType.fide.rawValue + Mode.classic.rawValue) : player.classicFideRating,
			(RatingType.fide.rawValue + Mode.rapid.rawValue) : player.rapidFideRating,
			(RatingType.fide.rawValue + Mode.blitz.rawValue) : player.blitzFideRating,
			(RatingType.fide.rawValue + Mode.bullet.rawValue) : player.blitzFideRating,
			(RatingType.fide.rawValue + Mode.chess960.rawValue) : player.classicFideRating,

			(RatingType.russian.rawValue + Mode.fide.rawValue) : player.classicFideRating,
			(RatingType.russian.rawValue + Mode.classic.rawValue) : player.classicFrcRating,
			(RatingType.russian.rawValue + Mode.rapid.rawValue) : player.rapidFrcRating,
			(RatingType.russian.rawValue + Mode.blitz.rawValue) : player.blitzFrcRating,
			(RatingType.russian.rawValue + Mode.bullet.rawValue) : player.blitzFrcRating,
			(RatingType.russian.rawValue + Mode.chess960.rawValue) : player.classicFrcRating,

			(RatingType.without.rawValue + Mode.fide.rawValue) : player.classicFideRating,
			(RatingType.without.rawValue + Mode.classic.rawValue) : player.classicFideRating,
			(RatingType.without.rawValue + Mode.rapid.rawValue) : player.rapidFideRating,
			(RatingType.without.rawValue + Mode.blitz.rawValue) : player.blitzFideRating,
			(RatingType.without.rawValue + Mode.bullet.rawValue) : player.blitzFideRating,
			(RatingType.without.rawValue + Mode.chess960.rawValue) : player.classicFideRating
		]
		return rating[ratingType.rawValue + mode.rawValue] ?? nil
	}
}

extension ManagerInteractor: EventCreationDelegate {
	func updateEvent(event: Tournament) {
		self.event = event
		let item = DispatchWorkItem { [weak self] in
			self?.output?.reloadEvent(event: event)
		}
		item.notify(queue: DispatchQueue.main) { [weak self] in
			self?.output?.reloadData(players: self!.usersSorted, elo: self!.averageRating, participants: self!.participantsCount)
		}
		DispatchQueue.main.async(execute: item)
	}
}
