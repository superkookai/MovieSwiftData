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
    case showFilter
    
    var id: Int {
        switch self {
            case .add:
                return 1
            case .edit(_):
                return 2
            case .showFilter:
                return 3
        }
    }
}

struct ContentView: View {
    
//    @Query(filter: #Predicate<Movie> {$0.year < 2000}, sort: \Movie.title) private var movies: [Movie]
    
    @Environment(\.modelContext) var context
    
    @State private var sheetAction: SheetAction?
    @State private var showActorsView: Bool = false
    @State private var filterOption: FilterOption = .none
    
    var body: some View {
        NavigationStack {
            MovieListView(filterOption: filterOption, sheetAction: $sheetAction)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 0) {
                            Button {
                                sheetAction = .add
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                            
                            Button {
                                if filterOption == .none {
                                    sheetAction = .showFilter
                                } else {
                                    filterOption = .none
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                    .foregroundStyle(filterOption == .none ? .blue : .red)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showActorsView.toggle()
                        } label: {
                            Text("Actors")
                        }
                    }
                }
        }
        .sheet(item: $sheetAction) { action in
            switch action {
            case .add:
                AddEditMovieView()
            case .edit(let movie):
                AddEditMovieView(movieToEdit: movie)
            case .showFilter:
                FilterView(filterOption: $filterOption)
            }
        }
        .fullScreenCover(isPresented: $showActorsView) {
            ActorsView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Movie.self)
}
