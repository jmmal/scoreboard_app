//
//  Innings.swift
//  ScoreboardApp
//
//  Created by Josh Maloney on 28/1/18.
//  Copyright © 2018 Josh Maloney. All rights reserved.
//

import UIKit

class Innings: UIStackView {
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInnings()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupInnings()
    }
    
    // MARK: Private Methods
    
    private func setupInnings() {
        let label = UILabel()
        label.backgroundColor = .red
        
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//        label.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        addArrangedSubview(label)
    }
    
}
