//
//  Film.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import Foundation

struct Film: Decodable {
    let Title: String
    let Year: String?
    let Rated: String?
    let Genre: String?
    let Plot: String?
    let Language: String?
    let Poster: String?
    let Ratings: [Rating]
    let imdbRating: String?
}

struct Rating: Decodable {
    let Source: String?
    let Value: String?
}

