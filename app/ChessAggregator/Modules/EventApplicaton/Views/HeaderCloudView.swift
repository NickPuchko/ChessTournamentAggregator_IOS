//
// Created by Николай Пучко on 05.01.2021.
//

import UIKit

class HeaderCloudView : AutoLayoutView {

    private var verticalStack = UIStackView()
    private var nameStack = UIStackView()
    private let teamImage: UIImageView
    private let locationImage: UIImageView
    private let ratingImage: UIImageView
    private let dateImage: UIImageView

    private let nameLabel: UILabel
    private let locationLabel: UILabel
    private let ratingLabel: UILabel
    private let dateLabel: UILabel

    init() {
        teamImage = UIImageView(image: UIImage(systemName: "checkerboard.rectangle")!) // replace with event admin picture
        teamImage.layer.cornerRadius = 30
        teamImage.clipsToBounds = true
        teamImage.layer.borderWidth = 1
        teamImage.layer.borderColor = UIColor.gray.cgColor

        locationImage = UIImageView(image: UIImage(systemName: "location")!)
        locationImage.tintColor = .black
        ratingImage = UIImageView(image: UIImage(systemName: "star")!) // chart.bar - alternative
        ratingImage.tintColor = .black
        dateImage = UIImageView(image: UIImage(systemName: "calendar")!)
        dateImage.tintColor = .black

        nameLabel = UILabel()
        nameLabel.text = "Название турнира"
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        nameLabel.numberOfLines = 0
        nameLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)

        locationLabel = UILabel()
        locationLabel.text = "Место проведения"
        locationLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        locationLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        ratingLabel = UILabel()
        ratingLabel.text = "0"
        ratingLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        ratingLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        dateLabel = UILabel()
        dateLabel.text = ""
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        super.init(frame: .zero)

        nameStack.addArrangedSubview(teamImage)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.axis = .horizontal
        nameStack.spacing = 4
        nameStack.alignment = .center
        nameStack.distribution = .fill

        let locationStack = UIStackView(arrangedSubviews: [locationImage, locationLabel])
        locationStack.axis = .horizontal
        locationStack.spacing = 4
        locationStack.alignment = .center

        let ratingStack = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        ratingStack.alignment = .center

        let dateStack = UIStackView(arrangedSubviews: [dateImage, dateLabel])
        dateStack.axis = .horizontal
        dateStack.spacing = 4
        dateStack.alignment = .center

        let mainContentStack = UIStackView(arrangedSubviews: [
            locationStack,
            ratingStack,
            dateStack
        ])

        mainContentStack.axis = .vertical
        mainContentStack.distribution = .fill
        mainContentStack.alignment = .leading
        mainContentStack.spacing = 8
        mainContentStack.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        mainContentStack.isLayoutMarginsRelativeArrangement = true

        verticalStack.addArrangedSubview(nameStack)
        verticalStack.addArrangedSubview(mainContentStack)

        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill
        verticalStack.setCustomSpacing(0, after: nameStack)
        verticalStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0) // TODO: pins - fix warnings
        verticalStack.isLayoutMarginsRelativeArrangement = true
        addSubview(verticalStack)
        verticalStack.pins()

        // may improve performance
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale

        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 18
        layer.shadowOpacity = 1
        layer.shadowRadius = 7
        layer.shadowOffset = .zero
        layer.shadowColor = layer.borderColor
    }
    convenience init(event: Tournament) {
        self.init()
        nameLabel.text = event.name
        locationLabel.text = event.location
        ratingLabel.text = event.ratingType.rawValue

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"


        let intervalFormatter = DateIntervalFormatter()
        intervalFormatter.locale = dateFormatter.locale
        intervalFormatter.dateStyle = .short
        intervalFormatter.timeStyle = .none

        let open = dateFormatter.date(from: event.openDate) ?? Date()
        let close = dateFormatter.date(from: event.closeDate) ?? Date()

        dateLabel.text = intervalFormatter.string(from: open, to: close)
    }

    override func setupConstraints() {
        super.setupConstraints()

        [teamImage, locationImage, ratingImage, dateImage, nameLabel, locationLabel, ratingLabel, dateLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }


        NSLayoutConstraint.activate([
            teamImage.heightAnchor.constraint(equalToConstant: 60),
            teamImage.widthAnchor.constraint(equalToConstant: 60),

            nameStack.widthAnchor.constraint(equalTo: widthAnchor),

            locationImage.heightAnchor.constraint(equalToConstant: 30),
            locationImage.widthAnchor.constraint(equalToConstant: 30),

            locationLabel.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            ratingImage.heightAnchor.constraint(equalTo: locationImage.heightAnchor),
            ratingImage.widthAnchor.constraint(equalTo: locationImage.widthAnchor),

            ratingLabel.heightAnchor.constraint(equalTo: ratingImage.heightAnchor),

            dateImage.heightAnchor.constraint(equalTo: ratingImage.heightAnchor),
            dateImage.widthAnchor.constraint(equalTo: ratingImage.widthAnchor),

            dateLabel.heightAnchor.constraint(equalTo: ratingLabel.heightAnchor),

        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with viewModel: EventViewModel) {
        nameLabel.text = viewModel.name
        locationLabel.text = viewModel.location
        ratingLabel.text = viewModel.ratingType
        dateLabel.text = viewModel.date
    }
}
