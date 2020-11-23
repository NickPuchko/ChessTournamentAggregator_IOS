

import Foundation

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
	var user: User?

	init() {
		self.user = loadUser()
	}

}

extension UserProfileInteractor: UserProfileInteractorInput {
	func getUserInformation() -> User {
		guard let checkedUser = user else {
			fatalError("Database cant get user data")
		}
		return checkedUser
	}

	func loadUser() -> User {
		//TODO get user information from Firebase
		let testUser = User(player: Player(
				fullName: "Пучко Николай",
				birthdate: Calendar.current.date(from: DateComponents(year: 2000, month: 7, day: 17))!, rating: 2045),
				phone: "88005553535", isAdmin: true)
		return testUser
	}
}
