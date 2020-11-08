//
// Created by Administrator on 08.11.2020.
//

import Foundation

class EventLocationCellModel: CellIdentifiable {
    var cellId: String {
        "EventLocationCell"
    }

    var location: String

    init(_ event: Tournament) {
        location = event.location
    }
}