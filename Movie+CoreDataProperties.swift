//
//  Movie+CoreDataProperties.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var filmGenre: String?
    @NSManaged public var filmRating: String?
    @NSManaged public var filmYear: String?
    @NSManaged public var filmName: String?
    @NSManaged public var filmPoster: String?

}
