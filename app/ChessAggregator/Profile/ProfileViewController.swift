//
// Created by Administrator on 09.11.2020.
//

import Foundation
import UIKit
import Firebase

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    var phone: String
    var ref: DatabaseReference

    init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
    }
}
