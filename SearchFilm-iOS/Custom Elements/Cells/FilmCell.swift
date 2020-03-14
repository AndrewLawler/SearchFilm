//
//  FilmCell.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {
    
    // UI Elements
    let filmPoster = UIImageView()
    let filmName = FilmLabel()
    let number = UIImageView()
    let folder = UIImageView()
    let numberLabel = FilmLabel()
    let folderLabel = FilmLabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(image: String, name: String, rating: String, genre: String) {
        let imgUrl = URL(string: image)
        filmPoster.load(url: imgUrl!)
        filmName.text = name
        folderLabel.text = genre
        numberLabel.text = rating
    }
    
    // custom Cell init
    private func configure() {
        
        // add subviews
        addSubview(filmPoster)
        addSubview(filmName)
        addSubview(number)
        addSubview(folder)
        addSubview(folderLabel)
        addSubview(numberLabel)
        
        // customise elements
        filmName.font = UIFont(name: "Helvetica-Bold", size: 25)
        filmName.textColor = .filmColour
        
        filmPoster.translatesAutoresizingMaskIntoConstraints = false
        
        number.image = UIImage(systemName: "person.crop.circle.badge.exclam")
        number.translatesAutoresizingMaskIntoConstraints = false
        number.tintColor = .filmColour
        
        folder.image = UIImage(systemName: "folder")
        folder.translatesAutoresizingMaskIntoConstraints = false
        folder.tintColor = .filmColour
        
        folderLabel.font = UIFont(name: "Helvetica-Medium", size: 15)
        numberLabel.font = UIFont(name: "Helvetica-Medium", size: 15)
        
        let padding: CGFloat = 10
        
        // constrain to the cell
        
        NSLayoutConstraint.activate([
            
            filmPoster.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            filmPoster.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            filmPoster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            filmPoster.widthAnchor.constraint(equalToConstant: 70),
            
            filmName.topAnchor.constraint(equalTo: filmPoster.topAnchor, constant: 5),
            filmName.leadingAnchor.constraint(equalTo: filmPoster.trailingAnchor, constant: 10),
            filmName.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            filmName.heightAnchor.constraint(equalToConstant: 30),
            
            number.topAnchor.constraint(equalTo: filmName.bottomAnchor, constant: 10),
            number.leadingAnchor.constraint(equalTo: filmPoster.trailingAnchor, constant: 10),
            number.widthAnchor.constraint(equalToConstant: 25),
            number.heightAnchor.constraint(equalToConstant: 20),
            
            folder.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 10),
            folder.leadingAnchor.constraint(equalTo: filmPoster.trailingAnchor, constant: 10),
            folder.widthAnchor.constraint(equalToConstant: 25),
            folder.heightAnchor.constraint(equalToConstant: 20),
            
            numberLabel.topAnchor.constraint(equalTo: filmName.bottomAnchor, constant: 10),
            numberLabel.leadingAnchor.constraint(equalTo: number.trailingAnchor, constant: 10),
            numberLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            numberLabel.heightAnchor.constraint(equalToConstant: 20),
            
            folderLabel.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 11),
            folderLabel.leadingAnchor.constraint(equalTo: folder.trailingAnchor, constant: 10),
            folderLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            folderLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
    }

}
