//
//  EventCreationViewController.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import UIKit

final class EventCreationViewController: UIViewController {
	private let output: EventCreationViewOutput

    init(output: EventCreationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white

        navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(endCreation))
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Опубликовать", style: .done, target: self, action: #selector(createDefault))
	}

    @objc
    private func createDefault() {
        output.createEvent()
    }

    @objc
    private func endCreation() {
        output.closeCreation()
    }
}

extension EventCreationViewController: EventCreationViewInput {
}
