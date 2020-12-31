//
//  EditUserViewController.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import UIKit

final class EditUserViewController: UIViewController, UIScrollViewDelegate {
	private let output: EditUserViewOutput
    private let stackView = ScrollableStackView(config: .defaultVertical)
    private let lastNameField = MaterialTextField()
    private let firstNameField = MaterialTextField()
    private let patronymicNameField = MaterialTextField()
    //private let fideField = MaterialTextField()
    //private let rfcField = MaterialTextField()

    init(output: EditUserViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.scrollView.delegate = self
        navigationController?.isNavigationBarHidden = false

        view.addSubview(stackView)
        stackView.pins()
        stackView.config.stack.spacing = 4
        stackView.config.pinsStackConstraints.top = 8
        stackView.config.pinsStackConstraints.left = 4
        stackView.config.pinsStackConstraints.right = -4
        view.backgroundColor = .white
        setupFields()

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(save))

    }

    private func setupFields() {
        let user = output.userState()
        lastNameField.placeholder = "Фамилия"
        lastNameField.text = user.player.lastName
        firstNameField.placeholder = "Имя"
        firstNameField.text = user.player.firstName
        patronymicNameField.placeholder = "Отчество"
        patronymicNameField.text = user.player.patronomicName

        stackView.addArrangedSubview(lastNameField)
        stackView.addArrangedSubview(firstNameField)
        stackView.addArrangedSubview(patronymicNameField)
    }

    @objc
    private func endCreation() {
        output.close()
    }

    @objc
    private func save() {
        var user = output.userState()
        // TODO: add check for empty (but not nil) textFields
        user.player.firstName = firstNameField.text ?? user.player.firstName
        user.player.lastName = lastNameField.text ?? user.player.lastName
        user.player.patronomicName = patronymicNameField.text
        
        output.editUser(with: user)
    }
}

extension EditUserViewController: EditUserViewInput {
}
