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
    private let genderField = MaterialTextField()
    private let genderPicker = UIPickerView()
    private let frcField = MaterialTextField()
    private let fideField = MaterialTextField()


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
        
        genderField.inputView = genderPicker
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignAll))
        //let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let rulesButton = UIBarButtonItem(title: "Правила FIDE", style: .plain, target: self, action: #selector(tapRules))
        toolbar.setItems([closeButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        genderField.placeholder = "Пол"
        if user.player.sex == "male" {
            genderField.text = "Мужчина"
            genderPicker.selectRow(0, inComponent: 0, animated: false)
        } else {
            genderField.text = "Женщина"
            genderPicker.selectRow(1, inComponent: 0, animated: false)
        }
        
        if let id = user.player.frcID {
            frcField.text = String(id)
        }
        frcField.placeholder = "ФШР ID"

        if let id = user.player.fideID {
            fideField.text = String(id)
        }
        fideField.placeholder = "FIDE ID"
        

        stackView.addArrangedSubview(lastNameField)
        stackView.addArrangedSubview(firstNameField)
        stackView.addArrangedSubview(patronymicNameField)
        stackView.addArrangedSubview(genderField)
        stackView.addArrangedSubview(frcField)
        stackView.addArrangedSubview(fideField)
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
        user.player.sex = genderField.text ?? user.player.sex
        if let ID = frcField.text {
            if let exactID = Int(ID) {
                user.player.frcID = Int(exactID)
            }
        }
        if let ID = fideField.text {
            if let exactID = Int(ID) {
                user.player.fideID = Int(exactID)
            }
        }

        
        output.editUser(with: user)
    }
    
    @objc
    private func resignAll() {
        view.endEditing(true)
    }
}

extension EditUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == genderPicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker {
            return 2 // male/female
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPicker {
            if row == 0 {
                return "Мужчина"
            } else {
                return "Женщина"
            }
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
            if row == 0 {
                genderField.text = "Мужчина"
            } else {
                genderField.text = "Женщина"
            }
        }
    }
    
    
}

extension EditUserViewController: EditUserViewInput {
}
