//
//  Movie.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import Foundation
import SwiftData

//@Attribute(.unique) and mnay options

@Model
class Movie {
    var title: String
    var year: Int
    
    //delete cascade means when delete Movie will delete all reviews related to that Movie
    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review]?
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}

@Model
class Review {
    var subject: String
    var body: String
    var movie: Movie?
    
    init(subject: String, body: String) {
        self.subject = subject
        self.body = body
    }
}
