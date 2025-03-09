//
//  MovieSwiftDataApp.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import SwiftUI

@main
struct MovieSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Movie.self, Review.self, Actor.self])
        }
    }
}


//If a model type contains a relationship, you may omit the destination model type from the array. SwiftData automatically traverses a model’s relationships and includes any destination model types for you.
//.modelContainer(for: Movie.self)
