//
//  EditUserInteractor.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class EditUserInteractor {
	weak var output: EditUserInteractorOutput?
	weak var editUserDelegate: EditUserDelegate!
}

extension EditUserInteractor: EditUserInteractorInput {
	func saveChanges(with user: User) {
		editUserDelegate.updateUser(user: user)
		DispatchQueue.global().async(qos: .background) {
			UserParser.updateUserInfo(user: user)
//			let realtimeDatabaseUser = UserParser.userToFirebaseUser(user: user)
//			FirebaseRef.ref.child("Users").child(Auth.auth().currentUser!.uid).setValue(realtimeDatabaseUser)
		}
	}
}
