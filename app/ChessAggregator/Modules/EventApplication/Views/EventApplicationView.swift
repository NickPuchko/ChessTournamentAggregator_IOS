//
// Created by Иван Лизогуб on 28.12.2020.
//

import UIKit

class EventApplicationView: UIView {

    private let applicationButton = UIButton()

    var onTapApplicationButton: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("not supported")
    }
    
    private func setup() {
        addSubview(applicationButton)
        applicationButton.backgroundColor = .black
        applicationButton.setTitle("Подать заявку", for: .normal)
        applicationButton.setTitleColor(.white, for: .normal)
        applicationButton.layer.cornerRadius = 12.0

        applicationButton.addTarget(self, action: #selector(onTapApplication), for: .touchUpInside)
    }

    private func setupConstraints() {
        applicationButton.translatesAutoresizingMaskIntoConstraints = false
        let margins = safeAreaLayoutGuide
        applicationButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        applicationButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        applicationButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        applicationButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }

    @objc private func onTapApplication() {
        onTapApplicationButton?()
    }
}
