
import Foundation
import FirebaseAuth

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
	var user: User?

	init() {
        FirebaseRef.ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").observe(.value) { [weak self] snapshot in
			self?.user = UserParser.userFromSnapshot(snapshot: snapshot)
            
            let ratings = UserParser.RateParser(frcID: self?.user?.player.frcID ?? 0)
            self?.user?.player.classicFideRating = ratings[0]
            self?.user?.player.rapidFideRating = ratings[1]
            self?.user?.player.blitzFideRating = ratings[2]
            self?.user?.player.classicFrcRating = ratings[3]
            self?.user?.player.rapidFrcRating = ratings[4]
            self?.user?.player.blitzFrcRating = ratings[5]

			self?.output!.updateUser(user: self!.user!)
		}
	}

}

extension UserProfileInteractor: UserProfileInteractorInput {
//    func reloadData() {
//        FirebaseRef.ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").observeSingleEvent(of: .value) { [weak self] snapshot in
//            self?.user = UserParser.userFromSnapshot(snapshot: snapshot)
//            self?.output!.updateUser(user: self!.user!)
//        }
//    }
}
