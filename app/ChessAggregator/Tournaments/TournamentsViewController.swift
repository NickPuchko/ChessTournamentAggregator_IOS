//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

class TournamentsViewController: UIViewController, TournamentsViewProtocol {

    var eventsCollectionView: UICollectionView!

    var presenter: TournamentsPresenterProtocol!
    let configurator: TournamentsConfiguratorProtocol! = TournamentsConfigurator()


    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        view.backgroundColor = .black
    }

    func loadEvents(_ events: [Tournament]) {
        //eventsCollectionView.dataSource = Data()
        print(events)
        //TODO: Поставить events в dataSource вместо принта
    }


}