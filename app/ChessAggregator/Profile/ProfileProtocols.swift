import FirebaseDatabase

protocol ProfileConfiguratorProtocol: class {
    func configure(with viewController: ProfileViewController)
}

protocol ProfileViewControllerProtocol: class {
    var testUser: User { get set }
    var phone: String { get set }
    var ref: DatabaseReference { get }
    init(ref: DatabaseReference, phone: String)
}

protocol ProfilePresenterProtocol: class {
    var router: ProfileRouterProtocol! { get set }
    //func configureView() // TODO: Вынести setup из VC в Presenter
    func editProfile()
    func createEvent()
    func showMyEvents()
    func showStatistics()
    func showFIDE()
    func showFRC()
}

protocol ProfileInteractorProtocol: class {
    var ref: DatabaseReference { get }
    var phone: String { get }
}
protocol ProfileRouterProtocol: class {
    func showEditor()
    func showCreator()
    func showMyEvents()
    func showStatistics()
    func showFIDE()
    func showFRC()
}
