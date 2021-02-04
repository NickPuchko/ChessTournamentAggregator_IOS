//
//  ManagerViewController.swift
//  ChessAggregator
//
//  Created by Administrator on 03.02.2021.
//  
//

import UIKit

final class ManagerViewController: UIViewController {
	private let output: ManagerViewOutput

    private var playerViewModels: [PlayerModel] = []
    private var managerView: ManagerView {
        view as! ManagerView
    }

    init(output: ManagerViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ManagerView(event: output.eventState(), onTapSite: output.onTapSite)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setup()
	}

    private func setup() {
        navigationController?.isNavigationBarHidden = false

        managerView.onTapManageButton = {[weak self] in
            self?.output.onTapManage()
        }
        managerView.startList.dataSource = self
    }
}

extension ManagerViewController: ManagerViewInput {
    func reloadView(players: [PlayerModel], elo: Int, participants: Int) {
        managerView.footerCloud.eloLabel.text = String(elo)
        managerView.footerCloud.participantsLabel.text = "👤 \(participants)"
        playerViewModels = players
        managerView.startList.reloadData()
    }

    func reloadEvent(event: Tournament) {
        managerView.updateView(event: event)
    }
}

extension ManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { playerViewModels.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "playerCell")
        let player = playerViewModels[indexPath.row]
        cell.textLabel?.text = player.name
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        if let rating = player.rating {
            cell.detailTextLabel?.text = String(rating)
            cell.detailTextLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        } else {
            cell.detailTextLabel?.text = ""
        }
        cell.imageView?.image = Styles.numberToImage(drawText: "\(indexPath.row + 1)") // Numbers

//        if indexPath.row < 50 {
//            cell.imageView?.image = UIImage(systemName: "\(indexPath.row + 1).circle") // Numbers in circles
//        } else {
//        }
        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int { 1 }
}
