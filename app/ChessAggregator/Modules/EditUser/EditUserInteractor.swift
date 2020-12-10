//
//  EditUserInteractor.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation

final class EditUserInteractor {
	weak var output: EditUserInteractorOutput?
}

extension EditUserInteractor: EditUserInteractorInput {
	func saveChanges() {
		print("Some extremely important changes have deployed")
	}

}
