//
// Created by Administrator on 08.11.2020.
//

import Foundation

class EventModeCellModel: CellIdentifiable {
    var cellId: String {
        "EventModeCell"
    }

    var mode: Mode

    init(_ event: Tournament) {
        mode = event.mode
    }
}
