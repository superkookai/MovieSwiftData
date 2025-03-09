//
//  MovieSelectionView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 09/03/2568.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {
    @Query(sort: \Movie.title, order: .reverse) private var movies: [Movie]
    @Binding var selectedMovies: Set<Movie>
    
    var body: some View {
        List(movies) { movie in
            HStack {
                Image(systemName: selectedMovies.contains(movie) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedMovies.contains(movie) {
                            selectedMovies.insert(movie)
                        } else {
                            selectedMovies.remove(movie)
                        }
                    }
                Text(movie.title.capitalized)
            }
        }
    }
}

#Preview {
    MovieSelectionView(selectedMovies: .constant([]))
        .modelContainer(for: Movie.self)
}
