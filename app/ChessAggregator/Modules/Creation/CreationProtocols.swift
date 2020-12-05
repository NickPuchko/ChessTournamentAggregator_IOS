import FirebaseDatabase

protocol CreationConfiguratorProtocol: class {
    func configure(with viewController: CreationViewController)
}

protocol CreationViewControllerProtocol: class {
    var phone: String { get set }
    var ref: DatabaseReference { get }
    init(ref: DatabaseReference, phone: String)
}

protocol CreationPresenterProtocol: class {
    var router: CreationRouterProtocol! { get set }
    func createEvent()
    func closeCreation()
}

protocol CreationInteractorProtocol: class {
    var ref: DatabaseReference { get }
    var phone: String { get }
    func saveEvent()
}
protocol CreationRouterProtocol: class {
    func closeCreation()
}
