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

    private let applicationView = EventApplicationView()

    init(output: EventApplicationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.addSubview(applicationView)
        self.view = view
        view.backgroundColor = .white
        setup()
        setupConstraints()
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}

    private func setup() {
        applicationView.onTapApplicationButton = {[weak self] in
            self?.output.onTapApplication()
        }
    }

    private func setupConstraints() {
        applicationView.translatesAutoresizingMaskIntoConstraints = false
        applicationView.pins()
    }


}

extension EventApplicationViewController: EventApplicationViewInput {
}

