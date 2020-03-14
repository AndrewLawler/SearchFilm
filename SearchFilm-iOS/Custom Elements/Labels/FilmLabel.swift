//
//  FilmLabel.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class FilmLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont(name: "Helvetica", size: 15)
        textColor = UIColor.systemGray
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }

}
