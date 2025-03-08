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
        HStack {
            Text(movie.title)
            Spacer()
            Text(String(movie.year))
        }
    }
}

#Preview {
    MovieRowView(movie: Movie(title: "Superman", year: 1999))
}
