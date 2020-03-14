//
//  FilmButton.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class FilmButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // custom button to use throughout
    init(bgColour: UIColor, title: String, titleColour: UIColor) {
        super.init(frame: .zero)
        configure()
        self.backgroundColor = bgColour
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColour, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
