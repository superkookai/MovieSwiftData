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
    
    //One-to-Many
    //delete cascade means when delete Movie will delete all reviews related to that Movie
    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review] = []
    
    //Many-to-Many
    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor] = []
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
    
    //Computed properties not persist
    var reviewCount: Int {
        reviews.count
    }
    
    var actorCount: Int {
        actors.count
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

@Model
class Actor {
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}
