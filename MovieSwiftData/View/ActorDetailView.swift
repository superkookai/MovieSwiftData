//
//  ActorDetailView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 09/03/2568.
//

import SwiftUI

struct ActorDetailView: View {
    var actor: Actor
    @State private var selectedMovies: Set<Movie> = []
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            Text(actor.name.capitalized)
                .font(.largeTitle)
            if !actor.movies.isEmpty {
                List(actor.movies) { movie in
                    MovieRowView(movie: movie)
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No Movies for \(actor.name.capitalized)", systemImage: "list.dash.header.rectangle")
            }
            
            VStack(alignment: .leading) {
                Text("Select Movies")
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                MovieSelectionView(selectedMovies: $selectedMovies)
            }
        }
        .onChange(of: selectedMovies) {
            actor.movies = Array(selectedMovies)
            do {
                try context.save()
            } catch {
                print("Error adding movies to actor: \(error)")
            }
        }
        .onAppear {
            self.selectedMovies = Set(actor.movies)
        }
    }
}

#Preview {
    NavigationStack {
        ActorDetailView(actor: Actor(name: "Galgadot"))
            .modelContainer(for: Actor.self)
    }
}


