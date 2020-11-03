//
//  AuthProtocols.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import Foundation

protocol AuthModuleInput {
	var moduleOutput: AuthModuleOutput? { get }
}

protocol AuthModuleOutput: class {
}

protocol AuthViewInput: class {
}

protocol AuthViewOutput: class {
}

protocol AuthInteractorInput: class {
}

protocol AuthInteractorOutput: class {
}

protocol AuthRouterInput: class {
}
