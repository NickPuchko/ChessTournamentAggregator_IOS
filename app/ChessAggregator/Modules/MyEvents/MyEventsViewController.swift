//
//  MyEventsViewController.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import UIKit

final class MyEventsViewController: UIViewController {
	private let output: MyEventsViewOutput

    private let items = UserSegments.allCases.map {$0.rawValue}
    private lazy var segmentedControl = UISegmentedControl(items: items)

    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView

    private var viewModels = [MyEventViewModel]()

    init(output: MyEventsViewOutput) {
        self.output = output
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        self.view = view
        setupSegmentedControl()
        setupCollectionView()
        setupConstraints()
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        output.viewDidLoad()
	}
}

extension MyEventsViewController: MyEventsViewInput {
    func updateView(with viewModels: [MyEventViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }
}

extension MyEventsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.item]
        let cell = self.collectionView.dequeueCell(cellType: MyEventViewCell<MyEventView>.self, for: indexPath)
        cell.containerView.update(with: viewModel)
        return cell
    }
}

extension MyEventsViewController: UICollectionViewDelegate {

}

extension MyEventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = 0.7
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = width * ratio
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }
}

private extension MyEventsViewController {
    func setupSegmentedControl() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0

    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(MyEventViewCell<MyEventView>.self)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 13.0, bottom: 0.0, right: 13.0)
    }

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        collectionView.pins()

    }

}

enum UserSegments: String, CaseIterable {
    case current = "Текущие", forthcoming = "Предстоящие", completed = "Завершенные"
}

enum OrganizerSegments: String, CaseIterable {
    case created = "Созданные", current = "Текущие", forthcoming = "Предстоящие", completed = "Завершенные"
}