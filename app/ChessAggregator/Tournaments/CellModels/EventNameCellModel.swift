//
// Created by Administrator on 08.11.2020.
//

import Foundation

class EventNameCellModel: CellIdentifiable {
    var cellId: String {
        "EventNameCell"
    }

    var name: String
    var date: String

    //var imageURL: URL?
    // TODO: Аватар турнира

    init(_ event: Tournament) {
        name = event.name
        date = event.date
    }

    // TODO: infoButton
}