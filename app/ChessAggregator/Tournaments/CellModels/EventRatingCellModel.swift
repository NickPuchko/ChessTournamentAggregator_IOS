
class EventRatingCellModel: CellIdentifiable {
    var cellId: String {
        "EventRatingCell"
    }

    var ratingType: RatingType

    init(_ event: Tournament) {
        ratingType = event.ratingType
    }
}
