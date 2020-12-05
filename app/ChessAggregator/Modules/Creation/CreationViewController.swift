import Foundation
import UIKit
import FirebaseDatabase


class CreationViewController: UIViewController, CreationViewControllerProtocol {

    var presenter: CreationPresenterProtocol!
    var configurator = CreationConfigurator()

    var ref: DatabaseReference
    var phone: String
    

    required init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Опубликовать", style: .done, target: self, action: #selector(createDefault))


        //setupConstraints()
    }

    @objc
    private func createDefault() {
        presenter.createEvent()
    }

    @objc
    private func endCreation() {
        presenter.closeCreation()
    }
}


