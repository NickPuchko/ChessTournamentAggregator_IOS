import FirebaseDatabase

protocol ProfileConfiguratorProtocol: class {
    func configure(with viewController: ProfileViewController)
}

protocol ProfileViewControllerProtocol: class {
    var phone: String { get set }
    var ref: DatabaseReference { get }
}

protocol ProfilePresenterProtocol: class {

}

protocol ProfileInteractorProtocol: class {

}
protocol ProfileRouterProtocol: class {

}