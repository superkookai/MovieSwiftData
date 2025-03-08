//
//  ContentView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import SwiftUI
import SwiftData

//-com.apple.CoreData.SQLDebug 1 >> Add this to Run Argument to print Debug

enum SheetAction: Identifiable {
    case add
    case edit(Movie)
    
    var id: Int {
        switch self {
            case .add:
                return 1
            case .edit(_):
                return 2
        }
    }
}

struct ContentView: View {
    @State private var sheetAction: SheetAction?
    @Query(sort: \Movie.title, order: .reverse) private var movies: [Movie]
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
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
            .environment(\.defaultMinListRowHeight, 70)
            .navigationTitle("Movies")
            .listStyle(.plain)
            .navigationDestination(for: Movie.self, destination: { movie in
                MovieDetailView(movie: movie)
            })
            .toolbar {
                Button {
                    sheetAction = .add
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .sheet(item: $sheetAction) { action in
            switch action {
            case .add:
                AddEditMovieView()
            case .edit(let movie):
                AddEditMovieView(movieToEdit: movie)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Movie.self)
}
