//
//  MovieListView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 10/03/2568.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    let filterOption: FilterOption
    @Binding var sheetAction: SheetAction?
    
    @Query var movies: [Movie]
    @Environment(\.modelContext) var context
    
    init(filterOption: FilterOption, sheetAction: Binding<SheetAction?>) {
        self.filterOption = filterOption
        self._sheetAction = sheetAction
        
        switch filterOption {
        case .none:
            _movies = Query()
        case .title(let movieTitle):
            _movies = Query(filter: #Predicate<Movie> { $0.title.contains(movieTitle)})
        case .reviewCount(let num):
            _movies = Query(filter: #Predicate<Movie> { $0.reviews.count >= num})
            //in #Predicate can use only properties that persist cannot use Transient properties (Properties that not persist, eg. Computed Properties
        }
    }
    
    var body: some View {
        List(movies) { movie in
            NavigationLink(value: movie) {
                MovieRowView(movie: movie)
            }
            .swipeActions {
                Button(role: .destructive) {
                    context.delete(movie)
                    do {
                        try context.save()
                    } catch {
                        print("Error deleting: \(error)")
                    }
                } label: {
                    Image(systemName: "trash")
                }
                
                Button {
                    sheetAction = .edit(movie)
                } label: {
                    Image(systemName: "pencil.circle")
                }
                
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 70)
        .navigationTitle("Movies")
        .navigationDestination(for: Movie.self, destination: { movie in
            MovieDetailView(movie: movie)
        })
        
    }
}

#Preview {
    NavigationStack {
        MovieListView(filterOption: .none, sheetAction: .constant(.add))
            .modelContainer(for: Movie.self)
    }
}
