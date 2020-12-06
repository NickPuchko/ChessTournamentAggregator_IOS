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

    private var labelTextField = MaterialTextField()
    private var locationTextField = MaterialTextField()
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

    init(output: EventCreationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        view.addSubview(scrollableStackView)
        scrollableStackView.translatesAutoresizingMaskIntoConstraints = false
        setupTextFields()
        setupDatePickers()
        setupStackView()
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


}


private extension EventCreationViewController {
    func setupStackView() {
        scrollableStackView.addArrangedSubview(labelTextField)
        scrollableStackView.addArrangedSubview(locationTextField)
        scrollableStackView.addArrangedSubview(dateView)
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

    func setupDatePickers() {

        //dateView.openDate.addTarget(self, action: #selector(editCloseDate), for: .editingDidEndOnExit)
    }
}

extension EventCreationViewController: EventCreationViewInput {
}
