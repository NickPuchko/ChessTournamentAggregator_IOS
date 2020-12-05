import UIKit

final class SearchTournamentsViewController: UIViewController {
	private let output: SearchTournamentsViewOutput
    private var sections: [EventSectionModel] = []
    private var filteredSections: [EventSectionModel] = []
    private var refreshControl = UIRefreshControl()

    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltered: Bool {
        searchController.isActive && !searchBarIsEmpty
    }

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return table
    }()

    private let searchController = UISearchController(searchResultsController: nil)

    init(output: SearchTournamentsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pins()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.configureView()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.sectionHeaderHeight = 0

        navigationController?.isNavigationBarHidden = false

        setupSearch()
    }


    @objc
    private func refresh() {
        output.refreshOnline()
        refreshControl.endRefreshing()
    }

}

extension SearchTournamentsViewController: SearchTournamentsViewInput {
    func loadEvents(_ sections: [EventSectionModel]) {
        self.sections = sections
    }
    func updateFeed() {
        self.tableView.reloadData()
    }

}

extension SearchTournamentsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        isFiltered ? output.showInfo(section: filteredSections[indexPath.section]) :
                output.showInfo(section: sections[indexPath.section])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            isFiltered ? output.showInfo(section: filteredSections[indexPath.section]) :
                    output.showInfo(section: sections[indexPath.section])
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

extension SearchTournamentsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        isFiltered ? filteredSections.count : sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredSections[section].rows.count : sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = isFiltered ? filteredSections[indexPath.section].rows[indexPath.row]
                : sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellId)
                ?? UITableViewCell(style: .default, reuseIdentifier: model.cellId)

        var config = cell.defaultContentConfiguration()

        switch indexPath.row {
        case 0:
            let nameCell = model as! EventNameCellModel
            config.text = nameCell.name
            config.textProperties.font = UIFont.systemFont(ofSize: 20)
            config.secondaryText = nameCell.date
            config.image = UIImage(systemName: "house") // TODO: avatar image
            cell.accessoryType = .detailButton

        case 1:
            let locationCell = model as! EventLocationCellModel
            config.text = locationCell.location
            config.image = UIImage(systemName: "location")
        case 2:
            let ratingTypeCell = model as! EventRatingCellModel
            config.text = ratingTypeCell.ratingType.rawValue
            config.image = UIImage(systemName: "crown")
        case 3:
            let modeCell = model as! EventModeCellModel
            config.text = modeCell.mode.rawValue
            config.image = UIImage(systemName: "clock")
        default:
            break
        }

        cell.contentConfiguration = config
        return cell
    }
}

extension SearchTournamentsViewController: UISearchResultsUpdating {

    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.isHidden = false
    }

    private func setupFilter() {
        //navigationController.but
    }

    private func filterContentForSearchText(searchText: String){
        filteredSections = sections.filter({ (section: EventSectionModel) -> Bool in
            section.event.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
    }
}
