//
// Created by Administrator on 05.11.2020.
//

import Foundation

class Player {
    let fullName: String
    let birthdate: Date
    let rating: Int


    required init(fullName: String, birthdate: Date, rating: Int?) {
        self.fullName = fullName
        self.birthdate = birthdate
        if let ELOrating = rating {
            self.rating = ELOrating
        } else {
            self.rating = 0
        }
    }
}
