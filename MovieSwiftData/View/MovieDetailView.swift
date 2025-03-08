//
//  MovieDetailView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle.weight(.heavy))
            Text(movie.year.description)
                .font(.title2)
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(title: "Superman", year: 1999))
}
