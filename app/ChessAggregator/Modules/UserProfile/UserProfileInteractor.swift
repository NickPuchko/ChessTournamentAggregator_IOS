
import Foundation
import FirebaseAuth

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
	var user: User?

	init() {
		FirebaseRef.ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").observeSingleEvent(of: .value) { [weak self] snapshot in
			self?.user = UserParser.userFromSnapshot(snapshot: snapshot)
			self?.output!.updateUser(user: self!.user!)
		}
	}

}

extension UserProfileInteractor: UserProfileInteractorInput {
}
