//
//  PreviewButton.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 09.04.2021.
//

import Foundation
import UIKit

import UIKit

class ConfigPreviewButton: AutoLayoutView {
    let mainView = UIView()
    let statisticsImage = UIImageView()

    init(image: UIImage) {
        super.init(frame: .zero)
        statisticsImage.image = image
        statisticsImage.contentMode = .scaleAspectFit
        setup()
    }

    private func setup() {

        statisticsImage.translatesAutoresizingMaskIntoConstraints = false

        mainView.addSubview(statisticsImage)

    }

    private var didSetupConstraints: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupConstraints() {
        super.setupConstraints()

        addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalTo: superview!.heightAnchor),
            mainView.widthAnchor.constraint(equalTo: superview!.widthAnchor, constant: -8),
            mainView.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: superview!.centerYAnchor),

            statisticsImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            statisticsImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            statisticsImage.widthAnchor.constraint(equalToConstant: 50.0),
            statisticsImage.heightAnchor.constraint(equalToConstant: 50.0), 
        ])
    }
}

extension UIButton {
  func addShadow() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    self.layer.shadowRadius = 7
    self.layer.shadowOpacity = 0.7
  }
}
