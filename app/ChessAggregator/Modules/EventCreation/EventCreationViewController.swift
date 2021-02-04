//
//  EventCreationViewController.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import UIKit
import FirebaseAuth


final class EventCreationViewController: UIViewController, UIScrollViewDelegate {
	private let output: EventCreationViewOutput

    private let labelTextField = MaterialTextField()
    private let locationTextField = MaterialTextField()
    let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 10),
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
        stack.spacing = 4
        return stack
    }()
    private let toursField = PickableTextField()
    private let ratingTypeField = PickableTextField()
    private let toursPicker = UIPickerView()
    private let ratingTypePicker = UIPickerView()
    private let modeSegment = UISegmentedControl(items: ["Классика FIDE", "Конфигуратор", "Шахматы 960"])
    private let timeControlPicker = UIPickerView()
    private let minutesField = PickableTextField()
    private let secondsField = PickableTextField()
    private let incrementField = PickableTextField()
    private let verticalTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    private let labelStack = LabelStack(first: "Минуты", second: "Секунды", third: "Инкремент")
    let timeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    private let modeField: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let fundField = PickableTextField()
    private let feeField = PickableTextField()
    private let urlField = MaterialTextField()

    var initialEvent: Tournament?
    private var newEvent: Tournament?

    init(output: EventCreationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadExiting(event: Tournament) {
        labelTextField.text = event.name
        labelTextField.placeholder = event.name

        locationTextField.text = event.location
        locationTextField.placeholder = event.location

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
        dateFormatter.dateFormat = "yyyy-MM-dd"

        dateView.openDate.setDate(dateFormatter.date(from: event.openDate) ?? Date(), animated: true)
        dateView.closeDate.setDate(dateFormatter.date(from: event.closeDate) ?? Date(), animated: true)

        urlField.text = event.url.absoluteString
        urlField.placeholder = event.url.absoluteString

        fundField.text = String(event.prizeFund)
        fundField.placeholder = String(event.prizeFund)

        feeField.text = String(event.fee)
        feeField.placeholder = String(event.fee)

        toursField.text = String(event.tours)

        minutesField.text = String(event.minutes)

        secondsField.text = String(event.seconds)

        incrementField.text = String(event.increment)

        timeControlPicker.selectRow(event.minutes - 1, inComponent: 0, animated: true)
        timeControlPicker.selectRow(event.seconds, inComponent: 1, animated: true)
        timeControlPicker.selectRow(event.increment, inComponent: 2, animated: true)

        ratingTypeField.text = event.ratingType.rawValue


        switch event.ratingType {
        case .fide:
            ratingTypePicker.selectRow(0, inComponent: 0, animated: true)
        case .russian:
            ratingTypePicker.selectRow(1, inComponent: 0, animated: true)
        case .without:
            ratingTypePicker.selectRow(2, inComponent: 0, animated: true)
        }

        switch event.mode {
        case .fide:
            modeSegment.selectedSegmentIndex = 0
            timeControlPicker.selectRow(89, inComponent: 0, animated: true)
            timeControlPicker.selectRow(0, inComponent: 1, animated: true)
            timeControlPicker.selectRow(30, inComponent: 2, animated: true)
        case .chess960:
            modeSegment.selectedSegmentIndex = 2
        default:
            modeSegment.selectedSegmentIndex = 1
        }

        tapSegment()
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
        setupDescriptionFields()
        scrollableStackView.scrollView.delegate = self

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))


        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        if let event = initialEvent {
            loadExiting(event: event)
            newEvent = initialEvent
            navigationItem.rightBarButtonItem =
                    UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(change))
            navigationItem.rightBarButtonItem?.isEnabled = false
            labelTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            locationTextField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            dateView.openDate.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            dateView.closeDate.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            urlField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            fundField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            feeField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            toursField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            ratingTypeField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            modeSegment.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
            ratingTypeField.addTarget(self, action: #selector(highlight), for: .allEditingEvents)
        } else {
            navigationItem.rightBarButtonItem =
                    UIBarButtonItem(title: "Опубликовать", style: .done, target: self, action: #selector(createDefault))
//            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         view.endEditing(true)
    }


    @objc func keyboardWillShow(notification: NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = scrollableStackView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollableStackView.scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollableStackView.scrollView.contentInset = contentInset
    }

    @objc
    private func highlight() {
//        print(initialEvent!)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
        dateFormatter.dateFormat = "yyyy-MM-dd"

//        print(dateFormatter.date(from: initialEvent!.openDate) == dateView.openDate.date)
//        print(timeControlPicker.selectedRow(inComponent: 0))
//        print(timeControlPicker.selectedRow(inComponent: 1))
//        print(timeControlPicker.selectedRow(inComponent: 2))
        if (initialEvent!.name        == labelTextField.text ?? "default"),
           (initialEvent!.location    == locationTextField.text ?? "default"),
           (dateFormatter.date(from: initialEvent!.openDate) == dateView.openDate.date),
           (dateFormatter.date(from: initialEvent!.closeDate) == dateView.closeDate.date),
           (initialEvent!.url         == URL(string: urlField.text ?? "default") ?? URL(string: "https://ruchess.ru/")!),
           (initialEvent!.prizeFund   == Int(fundField.text ?? "default") ?? 0),
           (initialEvent!.fee         == Int(feeField.text ?? "default") ?? 0),
           (initialEvent!.tours       == Int(toursField.text ?? "default") ?? 0),
           (initialEvent!.minutes     == timeControlPicker.selectedRow(inComponent: 0) + 1),
           (initialEvent!.seconds     == timeControlPicker.selectedRow(inComponent: 1)),
           (initialEvent!.increment   == timeControlPicker.selectedRow(inComponent: 2)),
           (initialEvent!.tours       == Int(toursField.text ?? "default") ?? 0),
           (initialEvent!.ratingType  == RatingType(rawValue: ratingTypeField.text ?? "default") ?? .without),
           checkSegment(initialEvent!.mode)
        {
            navigationItem.rightBarButtonItem?.tintColor = .black
            navigationItem.rightBarButtonItem?.isEnabled = false
            // TODO: time control check + date check
        } else {
            navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    private func checkSegment(_ type: Mode) -> Bool {
        switch type{
        case .fide:
            return modeSegment.selectedSegmentIndex == 0
        case .chess960:
            return modeSegment.selectedSegmentIndex == 2
        default:
            return modeSegment.selectedSegmentIndex == 1
        }
    }


    @objc
    private func change(){
        newEvent!.name        = labelTextField.text ?? newEvent!.name
        newEvent!.location    = locationTextField.text ?? newEvent!.location

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
//        dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
        dateFormatter.dateFormat = "yyyy-MM-dd"



        newEvent!.openDate    = dateFormatter.string(from: dateView.openDate.date)
        newEvent!.closeDate   = dateFormatter.string(from: dateView.closeDate.date)


        newEvent!.url         = URL(string: urlField.text ?? "default") ?? newEvent!.url
        newEvent!.prizeFund   = Int(fundField.text ?? "default") ?? newEvent!.prizeFund
        newEvent!.fee         = Int(feeField.text ?? "default") ?? newEvent!.fee
        newEvent!.tours       = Int(toursField.text ?? "default") ?? newEvent!.tours
        newEvent!.ratingType  = RatingType(rawValue: ratingTypeField.text ?? "default") ?? initialEvent!.ratingType

        switch modeSegment.selectedSegmentIndex {
        case 1:
            newEvent!.mode = Mode(rawValue: modeField.text ?? "default") ?? initialEvent!.mode
        case 2:
            newEvent!.mode = .chess960
        default:
            newEvent!.mode = .fide
        }
        newEvent!.minutes = Int(minutesField.text ?? "default") ?? initialEvent!.minutes
        newEvent!.seconds = Int(secondsField.text ?? "default") ?? initialEvent!.seconds
        newEvent!.increment = Int(incrementField.text ?? "default") ?? initialEvent!.increment

        output.updateEvent(event: newEvent!, index: modeSegment.selectedSegmentIndex, rateType: ratingTypeField.text ?? "")
    }

    @objc
    private func createDefault() {

        var event = Tournament()
        event.organizerId = Auth.auth().currentUser!.uid
        event.name        = labelTextField.text ?? "default"
        event.location    = locationTextField.text ?? "default"
        event.openDate    = String(dateView.openDate.date.description.prefix(10))
        event.closeDate   = String(dateView.closeDate.date.description.prefix(10))
        event.url         = URL(string: urlField.text ?? "default") ?? URL(string: "https://ruchess.ru/")!
        event.prizeFund   = Int(fundField.text ?? "default") ?? 0
        event.fee         = Int(feeField.text ?? "default") ?? 0
        event.tours       = Int(toursField.text ?? "default") ?? 0
        event.ratingType  = RatingType(rawValue: ratingTypeField.text ?? "default") ?? .without

        labelTextField.addTarget(self, action: #selector(setDefaultName), for: .editingChanged)
        locationTextField.addTarget(self, action: #selector(setDefaultLocation), for: .editingChanged)
        toursField.addTarget(self, action: #selector(setDefaultTours), for: .allEditingEvents)
        ratingTypeField.addTarget(self, action: #selector(setDefaultRate), for: .allEditingEvents)
        modeSegment.addTarget(self, action: #selector(setDefaultSegment), for: .valueChanged)
        
        switch modeSegment.selectedSegmentIndex {
        case 1:
            event.mode = Mode(rawValue: modeField.text ?? "default") ?? .classic
        case 2:
            event.mode = .chess960
        default:
            event.mode = .fide
        }
        event.minutes = Int(minutesField.text ?? "default") ?? 90
        event.seconds = Int(secondsField.text ?? "default") ?? 0
        event.increment = Int(incrementField.text ?? "default") ?? 30
        output.createEvent(event: event, index: modeSegment.selectedSegmentIndex, rateType: ratingTypeField.text ?? "")

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
    private func editFee() {
        if feeField.text == "" {
            feeField.becomeFirstResponder()
        } else {
            resignAll()
        }
    }

    @objc
    private func editFund() {
        if fundField.text == "" {
            fundField.becomeFirstResponder()
        } else {
            editFee()
        }
    }

    @objc
    private func tapSegment() {
        switch modeSegment.selectedSegmentIndex {
        case 1:
            modeField.text = output.chooseMode(
                    minutes: Int(minutesField.text ?? "1") ?? 1,
                    seconds: Int(secondsField.text ?? "0") ?? 0,
                    increment: Int(incrementField.text ?? "0") ?? 0
            ).rawValue
            timeStack.isHidden = false
            labelStack.isHidden = false
            modeField.isHidden = false
        case 2:
            modeField.text = "Шахматы Фишера - обсчёт рейтинга не предусмотрен"
            ratingTypeField.text = "Без обсчёта"
            ratingTypePicker.selectRow(2, inComponent: 0, animated: false)
            timeStack.isHidden = false
            labelStack.isHidden = false
            modeField.isHidden = false
        default:
            modeField.text = "90 минут на первые 40 ходов, затем 30 минут до окончания партии. Инкремент 30 секунд на ход"
            timeStack.isHidden = true
            labelStack.isHidden = true
            modeField.isHidden = false
            view.endEditing(true)
        }

        UIView.animate(withDuration: 0.5) {
            self.scrollableStackView.layoutIfNeeded()
        }
        highlight()
    }
}

private extension EventCreationViewController {
    func setupStackView() {
        scrollableStackView.addArrangedSubview(labelTextField)
        scrollableStackView.addArrangedSubview(locationTextField)
        scrollableStackView.addArrangedSubview(dateView)
        scrollableStackView.setCustomSpacing(30, after: dateView)
        scrollableStackView.addArrangedSubview(urlField)
        scrollableStackView.addArrangedSubview(fundField)
        scrollableStackView.addArrangedSubview(feeField)
        scrollableStackView.setCustomSpacing(30, after: feeField)
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

        timeControlPicker.selectRow(89, inComponent: 0, animated: true)
        timeControlPicker.selectRow(0, inComponent: 1, animated: true)
        timeControlPicker.selectRow(30, inComponent: 2, animated: true)


        minutesField.text = String(90)
        minutesField.textAlignment = .center
        secondsField.textAlignment = .center
        incrementField.text = String(30)
        incrementField.textAlignment = .center

        minutesField.inputView = timeControlPicker
        secondsField.inputView = timeControlPicker
        incrementField.inputView = timeControlPicker


        timeStack.addArrangedSubview(minutesField)
        timeStack.addArrangedSubview(secondsField)
        timeStack.addArrangedSubview(incrementField)

        modeField.isUserInteractionEnabled = false
        modeField.font = .italicSystemFont(ofSize: 12)
        modeField.text = Mode.classic.rawValue

        verticalTimeStack.addArrangedSubview(modeField)
        verticalTimeStack.addArrangedSubview(timeStack)
        verticalTimeStack.addArrangedSubview(labelStack)
        verticalTimeStack.arrangedSubviews.forEach{ $0.isHidden = true }
        scrollableStackView.setCustomSpacing(verticalTimeStack.spacing, after: modeSegment)
    }

    func setupDescriptionFields() {
        fundField.placeholder = "Призовой фонд, ₽"
        fundField.keyboardType = .numberPad
        feeField.placeholder = "Взнос, ₽"
        feeField.keyboardType = .numberPad
        urlField.placeholder = "Ссылка"
        urlField.keyboardType = .URL
        urlField.returnKeyType = .continue
        urlField.addTarget(self, action: #selector(editFund), for: .editingDidEndOnExit)
    }

}

extension EventCreationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == toursPicker {
            return 99
        } else if pickerView == timeControlPicker {
            switch component {
            case 0:
                return 600
            case 1:
                return 60
            default:
                return 601
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
            if modeSegment.selectedSegmentIndex == 1 {
                modeField.text = output.chooseMode(
                        minutes: Int(minutesField.text ?? "1") ?? 1,
                        seconds: Int(secondsField.text ?? "0") ?? 0,
                        increment: Int(incrementField.text ?? "0") ?? 0
                ).rawValue
            }
        default:
            ratingTypeField.text = RatingType.allCases[row].rawValue
        }
        if initialEvent != nil {
            highlight()
        }
    }
}

extension EventCreationViewController: EventCreationViewInput {
    
    func showWarningName(){
        
        labelTextField.layer.borderWidth = 1.0
        labelTextField.layer.borderColor = UIColor.red.cgColor
        
    }
    func showWarningLocation(){
        
        locationTextField.layer.borderWidth = 1.0
        locationTextField.layer.borderColor = UIColor.red.cgColor
        
    }
    func showWarningTours(){
        
        toursField.layer.borderWidth = 1.0
        toursField.layer.borderColor = UIColor.red.cgColor
        
    }
    func showWarningRate(){
        
        ratingTypeField.layer.borderWidth = 1.0
        ratingTypeField.layer.borderColor = UIColor.red.cgColor
        
    }
    func showWarningSegment(){
        
        modeSegment.layer.borderWidth = 1.0
        modeSegment.layer.borderColor = UIColor.red.cgColor
        
    }
    
    @objc func setDefaultName(){
        labelTextField.layer.borderWidth = 0
        labelTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func setDefaultLocation(){
        locationTextField.layer.borderWidth = 0
        locationTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func setDefaultTours(){
        
        if toursField.text != ""{
            toursField.layer.borderWidth = 0
            toursField.layer.borderColor = UIColor.white.cgColor
        }
        
    }
    @objc func setDefaultRate(){
        if ratingTypeField.text != ""{
            ratingTypeField.layer.borderWidth = 0
            ratingTypeField.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @objc func setDefaultSegment(){
        if modeSegment.selectedSegmentIndex == 2 {
            setDefaultRate()
        }
        modeSegment.layer.borderWidth = 0
        modeSegment.layer.borderColor = UIColor.white.cgColor
    }

}
