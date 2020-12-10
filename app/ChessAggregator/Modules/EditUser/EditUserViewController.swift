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
        view.backgroundColor = .white
        setupFields()

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(save))

    }

    private func setupFields() {
        lastNameField.placeholder = "Фамилия"
        firstNameField.placeholder = "Имя"
        patronymicNameField.placeholder = "Отчество"

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
        output.saveChanges()
    }
}

extension EditUserViewController: EditUserViewInput {
}
