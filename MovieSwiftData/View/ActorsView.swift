//
//  ActorsView.swift
//  MovieSwiftData
//
//  Created by Weerawut Chaiyasomboon on 09/03/2568.
//

import SwiftUI
import SwiftData

struct ActorsView: View {
    
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var actorName: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    private func addActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
        self.actorName = ""
        do {
            try context.save()
        } catch {
            print("Error save actor: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !actors.isEmpty {
                    List(actors) { actor in
                        NavigationLink(value: actor) {
                            ActorRowView(actor: actor)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ContentUnavailableView("No any actors", systemImage: "list.dash.header.rectangle")
                }
            }
            .navigationTitle("Actors")
            .navigationDestination(for: Actor.self, destination: { actor in
                ActorDetailView(actor: actor)
            })
            .toolbar(content: {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
            })
            .safeAreaInset(edge: .bottom) {
                VStack {
                    TextField("Actor Name", text: $actorName)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                        .autocorrectionDisabled()
                    
                    Button {
                        addActor()
                    } label: {
                        Text("Add Actor")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ActorsView()
        .modelContainer(for: Actor.self)
}

struct ActorRowView: View {
    let actor: Actor
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name.capitalized)
                .fontWeight(.bold)
            Text(actor.movies.map({$0.title}),format: .list(type: .and))
        }
    }
}
