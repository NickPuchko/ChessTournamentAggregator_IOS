import FirebaseDatabase

class CurrentInteractor: CurrentInteractorProtocol {
    weak var presenter: CurrentPresenterProtocol!
    var ref: DatabaseReference!
    var event: Tournament!

    required init(presenter: CurrentPresenterProtocol, ref: DatabaseReference, event: Tournament) {
        self.presenter = presenter
        self.ref = ref
        self.event = event
    }
}
