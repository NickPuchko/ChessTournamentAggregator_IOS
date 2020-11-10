//
// Created by Administrator on 09.11.2020.
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    var phone: String
    var ref: DatabaseReference

    var phoneLabel = UILabel()

    init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6

        phoneLabel.text = phone
        phoneLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(phoneLabel)

        phoneLabel.pins()
        phoneLabel.textAlignment = .center

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
