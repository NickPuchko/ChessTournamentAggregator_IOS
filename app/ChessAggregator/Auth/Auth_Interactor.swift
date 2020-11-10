import Foundation
import FirebaseDatabase

class Auth_Interactor: Auth_InteractorProtocol {
    weak var presenter: Auth_PresenterProtocol!
    var ref: DatabaseReference!

    required init(presenter: Auth_PresenterProtocol, ref: DatabaseReference) {
        self.presenter = presenter
        self.ref = ref
    }

    //TODO: Сделать верификацию пользователя из Firebase

}
