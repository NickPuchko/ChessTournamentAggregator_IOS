
class EventModeCellModel: CellIdentifiable {
    var cellId: String {
        "EventModeCell"
    }

    var mode: Mode

    init(_ event: Tournament) {
        mode = event.mode
    }
}
