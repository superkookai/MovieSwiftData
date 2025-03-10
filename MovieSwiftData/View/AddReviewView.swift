//
//  AddReviewView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import SwiftUI
import SwiftData

struct AddReviewView: View {
    let movie: Movie
    
    @State private var subject: String = ""
    @State private var description: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    private var isFormValid: Bool {
        !subject.isEmptyOrWhiteSpace && !description.isEmptyOrWhiteSpace
    }
    
    private func addReview() {
        let review = Review(subject: subject, body: description)
        review.movie = movie
        context.insert(review)
        movie.reviews.append(review)
        do {
            try context.save()
        } catch {
            print("Error add review: \(error)")
        }
        
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(movie.title)
                    .font(.title)
                Text(movie.year.description)
                
                Form {
                    TextField("Subject", text: $subject)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addReview()
                    } label: {
                        Text("Add")
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    AddReviewView(movie: Movie(title: "Wonder Woman", year: 1999))
        .modelContainer(for: Movie.self)
}
