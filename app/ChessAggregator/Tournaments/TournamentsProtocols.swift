import FirebaseDatabase

protocol TournamentsConfiguratorProtocol: class {
    func configure(with viewController: TournamentsViewController)
}

protocol TournamentsViewProtocol: class {
    var ref: DatabaseReference { get }
    var phone: String { get }
    init(ref: DatabaseReference, phone: String)
    func loadEvents(_ events: [EventSectionModel])
    func updateFeed()
}

protocol TournamentsPresenterProtocol: class {
    var router: TournamentsRouterProtocol! { get set }
    var sections: [EventSectionModel] { get set }
    func configureView()
    func updateView()
}

protocol TournamentsInteractorProtocol: class {
    var ref: DatabaseReference { get }
    var phone: String { get }
    var events: [Tournament] { get set }
    init(presenter: TournamentsPresenterProtocol, ref: DatabaseReference, phone: String)
    //func count(mode: Mode) -> Int
    //func count() -> Int
    func loadSections() -> [EventSectionModel]
}

protocol TournamentsRouterProtocol: class {
    func showApply()
    func showInfo(section: EventSectionModel)
}

protocol CellIdentifiable {
    var cellId: String { get }
}

