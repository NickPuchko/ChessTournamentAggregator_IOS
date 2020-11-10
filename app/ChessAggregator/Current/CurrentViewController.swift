//
// Created by Administrator on 09.11.2020.
//

import Foundation
import UIKit
import Firebase

class CurrentViewController: UIViewController, CurrentViewControllerProtocol {

    var phone: String
    var presenter: CurrentPresenterProtocol!
    var configurator: CurrentConfiguratorProtocol!

    var ref: DatabaseReference
    var event: Tournament

    var eventLabel = UILabel()

//    var currentView: CurrentView {
//        view as! CurrentView
//    }
//
//    override func loadView() {
//        view = CurrentView(event: event)
//    }
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6

        eventLabel.text = event.name
        eventLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        eventLabel.numberOfLines = 1
        eventLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(eventLabel)

        eventLabel.pins()
        eventLabel.textAlignment = .center
    }

    required init(ref: DatabaseReference, phone: String, event: Tournament) {
        self.ref = ref
        self.phone = phone
        self.event = event
        self.configurator = CurrentConfigurator()
        super.init(nibName: nil, bundle: nil)
    }

    init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        self.configurator = CurrentConfigurator()
        self.event = Tournament()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

//        let infoButton = UIBarButtonItem(
//                image: UIImage(systemName: "info"),
//                style: .plain,
//                target: self,
//                action: #selector(presenter.tappedInfo)
//        )
    }
}
