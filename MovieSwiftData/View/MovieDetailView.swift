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
    
    @State private var showAddReview: Bool = false
    
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle.weight(.heavy))
            Text(movie.year.description)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text("Actors")
                ActorsForMovieView(movie: movie)
            }
            .padding(.horizontal)
            
            Text("Reviews")
                .font(.title)
            
            if let reviews = movie.reviews, !reviews.isEmpty {
                List(reviews) { review in
                    ReviewRowView(review: review)
                        .swipeActions {
                            Button(role: .destructive) {
                                context.delete(review)
                                do {
                                    try context.save()
                                } catch {
                                    print("Error deleting review: \(error)")
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView("No reviews for \(movie.title)", systemImage: "list.dash.header.rectangle")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddReview.toggle()
                } label: {
                    Text("Add Review")
                }
            }
        }
        .sheet(isPresented: $showAddReview) {
            AddReviewView(movie: movie)
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: Movie(title: "Superman", year: 1999))
            .modelContainer(for: Movie.self)
    }
}

struct ReviewRowView: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.subject)
                .font(.title2)
            Text(review.body)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview("Review Row") {
    ReviewRowView(review: Review(subject: "Awesome!", body: "I love Superman in this version!"))
}

struct ActorsForMovieView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(movie.actors) { actor in
                    Text(actor.name.capitalized)
                        .font(.caption)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                }
            }
        }
        .frame(height: 50)
    }
}
