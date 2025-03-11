//
//  MovieRowView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            HStack {
                Text(movie.title)
                Spacer()
                Text(String(movie.year))
            }
            
            HStack {
                Text(movie.genre.title)
                Text("Actors: \(movie.actorCount)")
                Text("Reviews: \(movie.reviewCount)")
                Spacer()
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MovieRowView(movie: Movie(title: "Superman", year: 1999))
}
