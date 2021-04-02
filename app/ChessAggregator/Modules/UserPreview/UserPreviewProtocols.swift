//
//  UserPreviewProtocols.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 03.03.2021.
//  
//

import Foundation

protocol UserPreviewModuleInput {
	var moduleOutput: UserPreviewModuleOutput? { get }
}

protocol UserPreviewModuleOutput: class {
}

protocol UserPreviewViewInput: class {
}

protocol UserPreviewViewOutput: class {
    var userPreviewModel: UserPreviewModel? { get }
    func showFIDE()
    func showFRC()
}

protocol UserPreviewInteractorInput: class {
}

protocol UserPreviewInteractorOutput: class {
   
}

protocol UserPreviewRouterInput: class {
    func showFIDE(user: User)
    func showFRC(user: User)
}

