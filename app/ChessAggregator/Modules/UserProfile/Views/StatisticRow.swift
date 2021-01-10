//
// Created by Иван Лизогуб on 10.01.2021.
//

import UIKit

class StatisticRow: AutoLayoutView {
    let mainView = UIView()
    let label = UILabel()
    let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
    let statisticsImage = UIImageView(image: UIImage(systemName: "chart.bar.xaxis"))

    init(name: String) {
        super.init(frame: .zero)

        label.text = name
        setup()
    }

    private func setup() {
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 18
        mainView.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        statisticsImage.translatesAutoresizingMaskIntoConstraints = false

        arrow.tintColor = .black
        mainView.addSubview(statisticsImage)
        mainView.addSubview(label)
        mainView.addSubview(arrow)

        layer.borderColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5.5
        layer.shadowColor = UIColor.gray.cgColor
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

            statisticsImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 30),
            statisticsImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            statisticsImage.widthAnchor.constraint(equalToConstant: 50.0),
            statisticsImage.heightAnchor.constraint(equalToConstant: 50.0),

            label.leadingAnchor.constraint(equalTo: statisticsImage.trailingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

            arrow.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            arrow.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            arrow.widthAnchor.constraint(equalToConstant: 18.0),
            arrow.heightAnchor.constraint(equalToConstant: 23.0)
        ])
    }
}
