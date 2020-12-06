//
//  EventCreationViewController.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import UIKit

final class EventCreationViewController: UIViewController, UIScrollViewDelegate {
	private let output: EventCreationViewOutput

    private let labelTextField = MaterialTextField()
    private let locationTextField = MaterialTextField()
    let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 15.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 20.0, left: 8.0, bottom: 0.0, right: -8.0)
        )
        return ScrollableStackView(config: config)
    }()
    private let dateView = DoubleDate()
    private let pickerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    private let toursField = MaterialTextField()
    private let ratingTypeField = MaterialTextField()
    private let toursPicker = UIPickerView()
    private let ratingTypePicker = UIPickerView()
    private let modeSegment = UISegmentedControl(items: ["Классика FIDE", "Конфигуратор", "Шахматы 960"])
    private let timeControlPicker = UIPickerView()
    private let minutesField = MaterialTextField()
    private let secondsField = MaterialTextField()
    private let incrementField = MaterialTextField()
    private let verticalTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()

    private let labelStack = LabelStack(first: "Минуты", second: "Секунды", third: "Инкремент")


    init(output: EventCreationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        [scrollableStackView, pickerStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        view.addSubview(scrollableStackView)
        setupStackView()
        setupTextFields()
        setupPickerStack()
        setupToolbar()
        setupSegment()
        scrollableStackView.scrollView.delegate = self

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Опубликовать", style: .done, target: self, action: #selector(createDefault))
	}

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         view.endEditing(true)
    }

    @objc
    private func createDefault() {
        output.createEvent()
    }

    @objc
    private func endCreation() {
        output.closeCreation()
    }

    @objc
    private func editLocation() {
        if locationTextField.text == "" {
            locationTextField.becomeFirstResponder()
        } else {
            labelTextField.resignFirstResponder()
        }
    }

    @objc
    private func editOpenDate() {
        locationTextField.resignFirstResponder()
    }

    @objc
    private func resignAll() {
        view.endEditing(true)
    }

    @objc
    private func tapRules() {
        output.showRules()
    }

    @objc
    private func tapSegment() {
        switch modeSegment.selectedSegmentIndex {
        case 1:
            verticalTimeStack.isHidden = false
        case 2:
            verticalTimeStack.isHidden = false
        default:
            UIView.animate(withDuration: 0.5) {
                self.verticalTimeStack.isHidden = true
                self.view.endEditing(true)
                self.scrollableStackView.layoutIfNeeded()
            }
        }

        UIView.animate(withDuration: 0.5) {
            self.scrollableStackView.layoutIfNeeded()
        }
    }


}


private extension EventCreationViewController {
    func setupStackView() {
        scrollableStackView.addArrangedSubview(labelTextField)
        scrollableStackView.addArrangedSubview(locationTextField)
        scrollableStackView.addArrangedSubview(dateView)
        scrollableStackView.setCustomSpacing(24, after: dateView)
        scrollableStackView.addArrangedSubview(pickerStack)
        scrollableStackView.addArrangedSubview(modeSegment)
        scrollableStackView.addArrangedSubview(verticalTimeStack)
        scrollableStackView.pins()
    }

    func setupTextFields() {
        labelTextField.placeholder = "Название турнира"
        labelTextField.returnKeyType = .continue
        labelTextField.addTarget(self, action: #selector(editLocation), for: .editingDidEndOnExit)
        locationTextField.placeholder = "Место проведения"
        locationTextField.returnKeyType = .continue
        locationTextField.addTarget(self, action: #selector(editOpenDate), for: .editingDidEndOnExit)
    }

    func setupPickerStack() {
        toursPicker.delegate = self
        toursPicker.dataSource = self
        ratingTypePicker.delegate = self
        ratingTypePicker.dataSource = self

        toursField.placeholder = "Кол-во туров"
        toursField.inputView = toursPicker
        toursField.textAlignment = .center


        ratingTypeField.placeholder = "Рейтинг"
        ratingTypeField.inputView = ratingTypePicker
        ratingTypeField.textAlignment = .center

        pickerStack.addArrangedSubview(toursField)
        pickerStack.addArrangedSubview(ratingTypeField)
    }

    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignAll))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rulesButton = UIBarButtonItem(title: "Правила FIDE", style: .plain, target: self, action: #selector(tapRules))
        toolbar.setItems([rulesButton, spacer, closeButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        toursField.inputAccessoryView = toolbar
        ratingTypeField.inputAccessoryView = toolbar
        minutesField.inputAccessoryView = toolbar
        secondsField.inputAccessoryView = toolbar
        incrementField.inputAccessoryView = toolbar

    }

    func setupSegment() {
        modeSegment.backgroundColor = Styles.Color.fineGray
        modeSegment.addTarget(self, action: #selector(tapSegment), for: .valueChanged)

        timeControlPicker.delegate = self
        timeControlPicker.dataSource = self

        minutesField.text = String(90)
        minutesField.textAlignment = .center
        secondsField.textAlignment = .center
        incrementField.text = String(30)
        incrementField.textAlignment = .center

        minutesField.inputView = timeControlPicker
        secondsField.inputView = timeControlPicker
        incrementField.inputView = timeControlPicker

        let timeStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.alignment = .fill
            stack.spacing = 2
            return stack
        }()

        timeStack.addArrangedSubview(minutesField)
        timeStack.addArrangedSubview(secondsField)
        timeStack.addArrangedSubview(incrementField)

        verticalTimeStack.addArrangedSubview(timeStack)
        verticalTimeStack.addArrangedSubview(labelStack)

        verticalTimeStack.isHidden = true
    }
}

extension EventCreationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == toursPicker {
            return 98
        } else if pickerView == timeControlPicker {
            switch component {
            case 0:
                return 599
            case 1:
                return 60
            default:
                return 600
            }
        } else {
            return RatingType.allCases.count
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timeControlPicker {
            return 3
        } else {
            return 1
        }
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case toursPicker:
            return String(row + 1)
        case timeControlPicker:
            switch component {
            case 0:
                return String(row + 1)
            case 1:
                return String(row)
            default:
                return String(row)
            }
        default:
            return RatingType.allCases[row].rawValue
        }
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case toursPicker:
            toursField.text = String(row + 1)
        case timeControlPicker:
            switch component {
            case 0:
                minutesField.text = String(row + 1)
            case 1:
                secondsField.text = String(row)
            default:
                incrementField.text = String(row)
            }
        default:
            ratingTypeField.text = RatingType.allCases[row].rawValue
        }

    }
}

extension EventCreationViewController: EventCreationViewInput {
}
