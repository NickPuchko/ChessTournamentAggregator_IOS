//
// Created by Administrator on 05.11.2020.
//

import Foundation

class Auth_Interactor: Auth_InteractorProtocol {
    weak var presenter: Auth_PresenterProtocol!

    required init(presenter: Auth_PresenterProtocol) {
        self.presenter = presenter
    }

    //TODO: Сделать верификацию пользователя из Firebase

}
