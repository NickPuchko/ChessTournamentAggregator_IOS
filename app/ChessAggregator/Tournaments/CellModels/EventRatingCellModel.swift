//
// Created by Administrator on 08.11.2020.
//

import Foundation

class EventRatingCellModel: CellIdentifiable {
    var cellId: String {
        "EventRatingCell"
    }

    var ratingType: String

    init(_ event: Tournament) {
        ratingType = event.ratingType
    }
}
