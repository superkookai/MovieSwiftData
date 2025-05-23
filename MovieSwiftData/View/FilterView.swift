//
//  FilterView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 10/03/2568.
//

import SwiftUI

enum FilterOption: Equatable {
    case title(String)
    case reviewCount(Int)
    case genre(Genre)
    case none
}

struct FilterView: View {
    @Binding var filterOption: FilterOption
    @Environment(\.dismiss) var dismiss
    
    @State private var movieTitle: String = ""
    @State private var numOfReviews: String = ""
    @State private var genre: Genre = .none
    
    var body: some View {
        NavigationStack {
            Form {
                Section("By Movie Title") {
                    TextField("Movie Title", text: $movieTitle)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            if movieTitle.isEmpty {
                                filterOption = .none
                            } else {
                                filterOption = .title(movieTitle)
                            }
                            
                            dismiss()
                        }
                }
                
                Section("By Review Count") {
                    TextField("Number of Reviews", text: $numOfReviews)
                        .keyboardType(.numberPad)
                        .onSubmit {
                            if numOfReviews.isEmpty {
                                filterOption = .none
                            } else {
                                let num = Int(numOfReviews) ?? 0
                                filterOption = .reviewCount(num)
                            }
                            
                            dismiss()
                        }
                }
                
                Section("By Genre") {
                    Picker("Select Genre", selection: $genre) {
                        ForEach(Genre.allCases) { genre in
                            Text(genre.title).tag(genre)
                        }
                    }
                    .onChange(of: genre) {
                        filterOption = .genre(genre)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Filter View")
            .toolbar {
                Button {
                    filterOption = .none
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }

            }
        }
    }
}

#Preview {
    FilterView(filterOption: .constant(.none))
}
