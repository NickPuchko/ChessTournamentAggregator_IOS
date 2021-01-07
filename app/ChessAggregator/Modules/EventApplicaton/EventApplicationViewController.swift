//
//  EventApplicationViewController.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import UIKit

final class EventApplicationViewController: UIViewController {
	private let output: EventApplicationViewOutput

    private var applicationView: EventApplicationView {
        view as! EventApplicationView
    }

    init(output: EventApplicationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = EventApplicationView(event: output.eventState())
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setup()
	}

    private func setup() {
        applicationView.onTapApplicationButton = {[weak self] in
            self?.output.onTapApplication()
        }
    }
}

extension EventApplicationViewController: EventApplicationViewInput {
}

