
import Foundation
import FirebaseAuth

final class UserProfileInteractor {
	weak var output: UserProfileInteractorOutput?
	var user: User?
    //let apiClient = APIClient()

	init() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        FirebaseRef.ref.child("Users").child(uid).observeSingleEvent(of: .value, with: { [weak self] snapshot in
			self?.user = UserParser.userFromSnapshot(snapshot: snapshot, uid: uid)

            let ratings = UserParser.RateParser(frcID: self?.user?.player.frcID ?? 0)
            self?.user?.player.classicFideRating = ratings[3]
            self?.user?.player.rapidFideRating = ratings[4]
            self?.user?.player.blitzFideRating = ratings[5]
            self?.user?.player.classicFrcRating = ratings[0]
            self?.user?.player.rapidFrcRating = ratings[1]
            self?.user?.player.blitzFrcRating = ratings[2]

            self?.output!.updateUser(user: self!.user!)

            DispatchQueue.global().async(qos: .background) {
                let realtimeDatabaseUser = UserParser.userToFirebaseUser(user: self?.user ?? User())
                FirebaseRef.ref.child("Users").child(Auth.auth().currentUser!.uid).setValue(realtimeDatabaseUser)
            }
		})
    }
}

extension UserProfileInteractor: UserProfileInteractorInput {

}
