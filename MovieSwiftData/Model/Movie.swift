//
//  Movie.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import Foundation
import SwiftData

//@Attribute(.unique) and many options

//MARK: - Movie Model
@Model
class Movie {
    var title: String
    var year: Int
    var genreId: Int
    
    //One-to-Many
    //delete cascade means when delete Movie will delete all reviews related to that Movie
    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review] = []
    
    //Many-to-Many
    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor] = []
    
    init(title: String, year: Int, genre: Genre = .action) {
        self.title = title
        self.year = year
        self.genreId = genre.id
    }
    
    //Computed properties not persist
    var reviewCount: Int {
        reviews.count
    }
    
    var actorCount: Int {
        actors.count
    }
    
    var genre: Genre {
        Genre(rawValue: genreId)!
    }
}

//MARK: - Review Model
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

//MARK: - Actor Model
@Model
class Actor {
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}


//MARK: - Genre Model
enum Genre: Int, Codable, CaseIterable, Identifiable {
    case action = 1
    case horror
    case kids
    case fiction
    case comedy
    case romantic
    case none
    
    var id: Int {
        rawValue
    }
    
    var title: String {
        switch self {
        case .action:
            return "Action"
        case .horror:
            return "Horror"
        case .kids:
            return "Kids"
        case .fiction:
            return "Fiction"
        case .comedy:
            return "Comedy"
        case .romantic:
            return "Romantic"
        case .none:
            return "None"
        }
    }
}
