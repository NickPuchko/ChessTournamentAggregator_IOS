//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import Firebase

class UserRegistrationInteractor {
    weak var output: UserRegistrationInteractorOutput?
    private let phoneNumber: String

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

}

extension UserRegistrationInteractor: UserRegistrationInteractorInput {
    func addToDataBase(userReg: UserReg) {
        let user = createUserEntity(userReg: userReg)
        Auth.auth().createUser(
                withEmail: user.email,
                password: user.password
        ) { [weak self] authResult, error in
            if let firebaseUser = authResult?.user, error == nil {
                let realtimeDatabaseUser = UserParser.userToFirebaseUser(user: user)
                FirebaseRef.ref.child("Users").child(firebaseUser.uid).setValue(realtimeDatabaseUser)
                self?.signIn(withEmail: user.email, password: user.password)
                self?.output?.didRegister()
            } else {
                self?.output?.failedToAddAuthUser(error: error!.localizedDescription)
            }
        }
    }

    private func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in
            if let err = error {
                print(err.localizedDescription)
            }
        }
    }
}


private extension UserRegistrationInteractor {
    func createUserEntity(userReg: UserReg) -> User {
        let user = User(
                player: Player(
                        lastName: userReg.lastName, firstName: userReg.firstName, patronomicName:
                        userReg.patronymicName, birthdate: userReg.birthdate, sex: "М",
                        fideID: Int(userReg.fideID), frcID: Int(userReg.frcID)
                ),
                phone: phoneNumber, email: userReg.email, password: userReg.password, isOrganizer: userReg.isOrganizer,
        organizer: Organizer(organizationCity: userReg.organisationCity, organizationName: userReg.organisationName)
        )

        return user
    }
}
