//
//  TournamentsViewController.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import UIKit

final class TournamentsViewController: UIViewController {
	private let output: TournamentsViewOutput

    init(output: TournamentsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension TournamentsViewController: TournamentsViewInput {
}
