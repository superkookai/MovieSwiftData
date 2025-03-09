//
//  AddMovieView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import SwiftUI
import SwiftData

struct AddEditMovieView: View {
    var movieToEdit: Movie?
    @State private var title: String = ""
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = []
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && year != nil && !selectedActors.isEmpty
    }
    
    private var hasMovieToEdit: Bool {
        movieToEdit != nil
    }
    
    private func saveOrEdit() {
        if let movieToEdit {
            movieToEdit.title = self.title
            movieToEdit.year = self.year!
            movieToEdit.actors = Array(self.selectedActors)
            selectedActors.forEach { actor in
                actor.movies.append(movieToEdit)
                context.insert(actor)
            }
        } else {
            let movie = Movie(title: self.title, year: self.year!)
            movie.actors = Array(self.selectedActors)
            selectedActors.forEach { actor in
                actor.movies.append(movie)
                context.insert(actor)
            }
            context.insert(movie)
        }
        
        do {
            try context.save()
        } catch {
            print("ERROR: \(error)")
        }
        
        dismiss()
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                    .autocorrectionDisabled()
                TextField("Year", value: $year, format: .number)
                    .autocorrectionDisabled()
                    .keyboardType(.numberPad)
                
                Section("Select actors") {
                    ActorSelectionView(selectedActors: $selectedActors)
                }
                
            }
            .navigationTitle(hasMovieToEdit ? "Edit Movie" : "Add Movie")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveOrEdit()
                    } label: {
                        Text(hasMovieToEdit ? "Update" : "Save")
                    }
                    .disabled(!isFormValid)
                    
                }
            }
            .onAppear {
                if let movieToEdit {
                    self.title = movieToEdit.title
                    self.year = movieToEdit.year
                    self.selectedActors = Set(movieToEdit.actors)
                }
            }
        }
    }
}

#Preview {
    AddEditMovieView()
        .modelContainer(for: Movie.self)
}
