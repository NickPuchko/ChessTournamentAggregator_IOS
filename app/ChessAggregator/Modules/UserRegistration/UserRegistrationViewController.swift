//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import UIKit

class UserRegistrationViewController: UIViewController {
    let output: UserRegistrationViewOutput

    private let registrationView = UserRegistrationPlayerView()

    private lazy var adapter = KeyboardAdapter(window: self.view.window) { [weak self] offset, duration in
        self?.keyboardOffsetChanged(offset, duration: duration)
    }

    init(output: UserRegistrationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboard")
    }

    override func loadView() {
        self.view = registrationView
        self.view.backgroundColor = .systemGray6
        self.setup()
    }

    private func setup() {
        registrationView.onTapRegistrationButton = { [weak self]
            lastName, firstName, patronymicName,
            FideID, CFRID, emailAddress, password, validatePassword,
            isOrganizer, organisationCity, organisationName,
            birthdate in

            self?.output.onTapRegistration(
                    lastName: lastName, firstName: firstName, patronymicName: patronymicName, FideID: FideID,
                    CFRID: CFRID, email: emailAddress, password: password, passwordValidation: validatePassword,
                    isOrganizer: isOrganizer, organizationCity: organisationCity, organizationName: organisationName,
                    birthdate: birthdate
            )

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adapter.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        adapter.stop()
    }

}

extension UserRegistrationViewController: UserRegistrationViewInput {

    func showLastNameWarning(isHidden: Bool) {
        registrationView.lastNameWarning.animatedAppearance(isHidden: isHidden)
    }

    func showFirstNameWarning(isHidden: Bool) {
        registrationView.firstNameWarning.animatedAppearance(isHidden: isHidden)
    }

    func showEmailWarning(isHidden: Bool) {
        registrationView.emailAddressWarning.animatedAppearance(isHidden: isHidden)
    }

    func showPasswordWarning(isHidden: Bool) {
        registrationView.passwordWarning.animatedAppearance(isHidden: isHidden)
    }

    func showValidatePasswordWarning(isHidden: Bool) {
        registrationView.validatePasswordWarning.animatedAppearance(isHidden: isHidden)
    }

    func showOrganizationNameWarning(isHidden: Bool) {
        registrationView.organizationNameWarning.animatedAppearance(isHidden: isHidden)
    }

}

extension UserRegistrationViewController: UITextFieldDelegate {

}


private extension UserRegistrationViewController {
    func keyboardOffsetChanged(_ offset: CGFloat, duration: TimeInterval) {
        let contentInsets = UIEdgeInsets(
                top: 0.0, left: 0.0,
                bottom: offset + registrationView.registrationOffset, right: 0.0
        )
        registrationView.scrollableStackView.set(contentInset: contentInsets)
    }

    func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tap)
    }

    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}