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
    let gamePlayer1Label = UILabel()
    let gamePlayer2Label = UILabel()
    let gameResultLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameNumberLabel)
        //contentView.addSubview(gameMembersLabel)
        contentView.addSubview(gameResultLabel)
        contentView.addSubview(gamePlayer1Label)
        contentView.addSubview(gamePlayer2Label)
        //contentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        setupLabels()
        setupLabelsConstraint()
    }
    func setupLabels() {
        gameNumberLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        gameNumberLabel.textColor = .black
        
        gamePlayer1Label.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        gamePlayer1Label.textColor = .black
        gamePlayer1Label.text = "Surkov.M.A"
        gamePlayer1Label.lineBreakMode = .byCharWrapping
        
        gamePlayer2Label.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        gamePlayer2Label.textColor = .black
        gamePlayer2Label.text = "Puchko.N.Aasjndljaksndjkansdklansdklajsndkjasdnklansdkljandskaksdj"
        gamePlayer2Label.lineBreakMode = .byCharWrapping
        
        gameResultLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        gameResultLabel.textColor = .black
        
        gameResultLabel.text = "0 - 1"
    }
    
    func setupLabelsConstraint() {
        gameNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        gameResultLabel.translatesAutoresizingMaskIntoConstraints = false
        gamePlayer1Label.translatesAutoresizingMaskIntoConstraints = false
        gamePlayer2Label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gameNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            gameResultLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gameResultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            gamePlayer1Label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            gamePlayer1Label.leadingAnchor.constraint(equalTo: gameNumberLabel.trailingAnchor, constant: 12),
            gamePlayer1Label.trailingAnchor.constraint(lessThanOrEqualTo: gameResultLabel.leadingAnchor, constant: -15),
            
            gamePlayer2Label.topAnchor.constraint(equalTo: gamePlayer1Label.bottomAnchor, constant: 4),
            gamePlayer2Label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            gamePlayer2Label.leadingAnchor.constraint(equalTo: gamePlayer1Label.leadingAnchor),
            gamePlayer2Label.trailingAnchor.constraint(lessThanOrEqualTo: gameResultLabel.leadingAnchor, constant: -15),
        ])
        gameNumberLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        gamePlayer1Label.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        gamePlayer2Label.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
