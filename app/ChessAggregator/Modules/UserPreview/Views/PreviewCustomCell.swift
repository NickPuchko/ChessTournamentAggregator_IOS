//
//  PreviewCustomCell.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 09.04.2021.
//

import Foundation
import UIKit

class PreviewCustomCell: UITableViewCell {
    
    let gameNumberLabel = UILabel()
    let gameMembersLabel = UILabel()
    let gameResultLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameNumberLabel)
        contentView.addSubview(gameMembersLabel)
        contentView.addSubview(gameResultLabel)
        
        setupLabels()
        setupLabelsConstraint()
    }
    func setupLabels() {
        gameNumberLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        gameMembersLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        gameResultLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        
        gameNumberLabel.textColor = .black
        gameMembersLabel.textColor = .black
        gameResultLabel.textColor = .black
        
        gameMembersLabel.text = "Surkov.M.A - Puchko.N.A"
        gameResultLabel.text = "0 - 1"
    }
    
    func setupLabelsConstraint() {
        gameNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        gameMembersLabel.translatesAutoresizingMaskIntoConstraints = false
        gameResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gameNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),         //gameNumberLabel.widthAnchor.constraint(equalToConstant: 15),
//            gameNumberLabel.heightAnchor.constraint(equalTo:gameNumberLabel.widthAnchor),
            
            gameResultLabel.topAnchor.constraint(equalTo: gameNumberLabel.topAnchor),
            gameResultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            gameMembersLabel.topAnchor.constraint(equalTo: gameNumberLabel.topAnchor),
            gameMembersLabel.leadingAnchor.constraint(equalTo: gameNumberLabel.trailingAnchor, constant: 8),
            //gameMembersLabel.trailingAnchor.constraint(lessThanOrEqualTo: gameResultLabel.leadingAnchor, constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
