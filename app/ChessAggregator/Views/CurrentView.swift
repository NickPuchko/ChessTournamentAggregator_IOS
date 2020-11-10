//
// Created by Administrator on 10.11.2020.
//

import Foundation
import UIKit

class CurrentView: AutoLayoutView {
    var infoButton = UIButton(type: .infoDark)
    var eventLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 30))

    var onTapInfoButton: (() -> Void)?


    init(event: Tournament) {
        super.init(frame: .zero)
        setup(event: event)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(event: Tournament) {
//        backgroundColor = .systemGray6
//        var view = UIView()
//        eventLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(eventLabel)
//        eventLabel.text = event.name
//        addSubview(view)


    }

    override func setupConstraints() {
        super.setupConstraints()

    }
}
