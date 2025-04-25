//
//  ReviewListView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 25/04/2568.
//

import SwiftUI
import SwiftData

struct ReviewListView: View {
    @Query var reviews: [Review]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(reviews) { review in
                ReviewRowView(review: review)
            }
            .listStyle(.plain)
            .navigationTitle("Reviews")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }

                }
            }
        }
    }
}

#Preview {
    ReviewListView()
        .modelContainer(ModelPreview.previewContainer)
}
