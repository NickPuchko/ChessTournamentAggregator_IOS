
class EventSectionModel {
    var rows: [CellIdentifiable]
    let event: Tournament
    init(event: Tournament) {
        self.event = event
        rows = []

        rows.append(EventNameCellModel(event))
        rows.append(EventLocationCellModel(event))
        rows.append(EventRatingCellModel(event))
        rows.append(EventModeCellModel(event))
        // TODO: add apply button Cell
    }
}


