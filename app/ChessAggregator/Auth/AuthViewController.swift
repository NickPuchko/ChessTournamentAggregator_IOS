//
//  AuthViewController.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import UIKit

final class AuthViewController: UIViewController {
	private let output: AuthViewOutput

    init(output: AuthViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var authView: AuthView {
        view as! AuthView
    }

    override func loadView() {
        view = AuthView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Авторизация"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDone))

        authView.onTapLoginButton = { [weak self] in
            let alert = UIAlertController(title: "Мы вошли!", message: "На самом деле нет. Ждём Firebase", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ну ладно", style: .default, handler: { _ in  NSLog("Enter alert occurred")}))
            self?.present(alert, animated: true, completion: nil)
        }
	}

    @objc
    private func didTapDone() {
        navigationController?.pushViewController(TournamentsVC(), animated: true)
    }
}

extension AuthViewController: AuthViewInput {
}


