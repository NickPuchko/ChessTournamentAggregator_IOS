
import Foundation
import FirebaseAuth

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
	var user: User?

	init() {
		user = User()
		FirebaseRef.ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").observeSingleEvent(of: .value) { [weak self] snapshot in
			self?.user = UserParser.userFromSnapshot(snapshot: snapshot)
			self?.output!.updateUser(user: self!.user!)
		}
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
				birthdate: Calendar.current.date(from: DateComponents(year: 2000, month: 7, day: 17))!, classicFideRating: 2045),
				phone: "88005553535", isOrganizer: true)
		return testUser
	}
}
