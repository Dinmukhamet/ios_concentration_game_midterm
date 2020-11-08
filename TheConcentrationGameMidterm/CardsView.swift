//
//  CardsView.swift
//  TheConcentrationGameMidterm
//
//  Created by Dinmukhamet Igissinov on 10/31/20.
//

import UIKit

class CardsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        let values = [""]
        
        translatesAutoresizingMaskIntoConstraints = false

        let cardsGridStackView = UIStackView()
        cardsGridStackView.axis = .vertical
        cardsGridStackView.distribution = .fillEqually
        cardsGridStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cardsGridStackView)
        
        let numberOfRows = 4

        for _ in 0..<numberOfRows {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            
            for _ in 0..<numberOfRows {
                let cardButton = UIButton()
                cardButton.setTitle("🍒", for: .normal)
                rowStackView.addArrangedSubview(cardButton)
            }
            
            cardsGridStackView.addArrangedSubview(rowStackView)
        }
    
        
        setupLayout(cardsGridStackView: cardsGridStackView)
        
        setNeedsUpdateConstraints()
    }
    
    private func setupLayout(cardsGridStackView: UIStackView) {
        let cardsGridStackViewConstraints = [
            cardsGridStackView.topAnchor.constraint(equalTo: topAnchor),
            cardsGridStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardsGridStackView.leftAnchor.constraint(equalTo: leftAnchor),
            cardsGridStackView.rightAnchor.constraint(equalTo: rightAnchor)
        ]
        NSLayoutConstraint.activate(cardsGridStackViewConstraints)
    }
    
}
