
class EventLocationCellModel: CellIdentifiable {
    var cellId: String {
        "EventLocationCell"
    }

    var location: String

    init(_ event: Tournament) {
        location = event.location
    }
}