//
// Created by Administrator on 09.11.2020.
//

import Firebase

protocol CurrentConfiguratorProtocol: class {
    func configure(with viewController: CurrentViewControllerProtocol)
}

protocol CurrentViewControllerProtocol: class {
    var presenter: CurrentPresenterProtocol! { get set }
    var configurator: CurrentConfiguratorProtocol! { get set }
    var phone: String { get }
    var ref: DatabaseReference { get }
    var event: Tournament { get }
}

@objc
protocol CurrentPresenterProtocol: class {

    func tappedInfo()
}

protocol CurrentInteractorProtocol: class {

}

protocol CurrentRouterProtocol: class {
    func showInfo()
}
