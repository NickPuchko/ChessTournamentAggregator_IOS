import Foundation
import UIKit
import FirebaseDatabase


class CreationViewController: UIViewController, CreationViewControllerProtocol {

    var presenter: CreationPresenterProtocol!
    var configurator = CreationConfigurator()

    var ref: DatabaseReference
    var phone: String

    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создай уже что-нибудь!", for: .normal)
        return button
    }()
    

    required init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)

        createButton.addTarget(self, action: #selector(createDefault), for: .touchUpInside)
        view.addSubview(createButton)

        setupConstraints()
    }
    
    func setupConstraints() {
        createButton.pins()
    }

    @objc
    func createDefault() {
        presenter.createEvent()
    }
}


