//
//  ModelPreview.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 11/03/2568.
//

import Foundation
import SwiftData

@MainActor
struct ModelPreview {
    static var previewContainer: ModelContainer = {
        let schema = Schema([Movie.self, Review.self, Actor.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: config)
        
        // Add sample data
        let sampleMovie = Movie(title: "Sample Movie", year: 2024, genre: .action)
        container.mainContext.insert(sampleMovie)
        
        return container
    }()
}
