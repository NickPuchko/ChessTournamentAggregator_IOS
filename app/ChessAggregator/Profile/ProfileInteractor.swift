//
// Created by Administrator on 21.11.2020.
//

import Foundation
import FirebaseDatabase

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol!
    var ref: DatabaseReference
    var phone: String

    required init(presenter: ProfilePresenterProtocol, ref: DatabaseReference, phone: String) {
        self.presenter = presenter
        self.ref = ref
        self.phone = phone
    }

}
