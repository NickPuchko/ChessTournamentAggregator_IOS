//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

class TournamentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TournamentsViewProtocol {

    var presenter: TournamentsPresenterProtocol!
    let configurator: TournamentsConfiguratorProtocol = TournamentsConfigurator()

    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)


    var sections: [EventSectionModel] = []

    override func loadView() {
        view = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pins()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()

        tableView.dataSource = self
        tableView.delegate = self
        //tableView.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
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
            config.text = ratingTypeCell.ratingType
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

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        presenter.router.showInfo(section: sections[indexPath.section])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenter.router.showInfo(section: sections[indexPath.section])
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    internal func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }


    func loadEvents(_ sections: [EventSectionModel]) {
        self.sections = sections
    }
}