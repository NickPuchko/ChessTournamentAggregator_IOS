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
            if let err = error {
                self?.output?.failedToAddAuthUser(error: err.localizedDescription)
            } else {
                guard let firebaseUser = authResult?.user else { fatalError("UserRegistrationInteractor no user") }
                let value = UserParser.userToFirebaseUser(user: user)
                FirebaseRef.ref.child("Users").child(firebaseUser.uid).setValue(value)
                self?.output?.didRegister()
            }
        }
    }
}


private extension UserRegistrationInteractor {
    func createUserEntity(userReg: UserReg) -> User {
        let firstNameWithSpace = " " + userReg.firstName
        var patronymicNameWithSpace = ""
        if let patName = userReg.patronymicName, patName != "" {
            patronymicNameWithSpace = " " + patName
        }
        else {
            patronymicNameWithSpace = ""
        }
        let fullName = userReg.lastName + firstNameWithSpace + patronymicNameWithSpace

        let user = User(
                player: Player(
                        fullName: fullName, birthdate: userReg.birthdate,
                        fideID: Int(userReg.fideID), frcID: Int(userReg.frcID)
                ),
                phone: phoneNumber, email: userReg.email, password: userReg.password, isOrganizer: userReg.isOrganizer
        )

        return user
    }
}