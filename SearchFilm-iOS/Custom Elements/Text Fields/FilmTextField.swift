//
//  FilmTextField.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class FilmTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // custom Init
    init(place: String) {
        super.init(frame: .zero)
        self.placeholder = place
        configure()
    }
    
    // configuring styling
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.filmColour.cgColor
        
        textColor = .filmColour
        tintColor = .systemGray
        textAlignment = .center
        font = UIFont(name: "Helvetica", size: 15)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .white
        autocorrectionType = .no
        returnKeyType = .default
        clearButtonMode = .whileEditing
    }
    
}
