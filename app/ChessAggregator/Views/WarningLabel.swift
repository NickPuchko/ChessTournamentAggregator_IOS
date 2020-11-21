//
// Created by Иван Лизогуб on 17.11.2020.
//

import Foundation
import UIKit

class WarningLabel: UILabel {
    init() {
        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.textColor = .systemRed
        self.font = .boldSystemFont(ofSize: 15.0)
        self.isHidden = true
        self.numberOfLines = 0
    }
}