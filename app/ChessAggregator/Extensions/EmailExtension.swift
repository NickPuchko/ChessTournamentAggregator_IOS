//
// Created by Иван Лизогуб on 10.11.2020.
//

import Foundation
import UIKit

extension String {
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
}

extension UITextField {
    func isEmail() -> Bool {
        return self.text!.isEmail()
    }
}