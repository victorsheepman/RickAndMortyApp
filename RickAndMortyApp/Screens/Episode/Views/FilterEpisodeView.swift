//
//  FilterEpisodeView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 17/7/24.
//

import SwiftUI

struct FilterEpisodeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filter: EpisodeFilter
    
    var manager: EpisodeOO
    
    private var isApplyDisabled: Bool {
        [filter.episode, filter.name]
            .allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $filter.name,
                    title: "Name",
                    placeholder: "Give a name"
                )
                Divider()
                Divider()
                    .padding(.top, 15)
            
                SearchItem(
                    textToSearch: $filter.episode,
                    title: "Episode",
                    placeholder: "Select one"
                )
                
                Divider()

                Spacer()
                
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear"){
                        clean()
                        dismiss()
                    }
                    .tint(.indigo)
                }
                ToolbarItem(placement: .principal) {
                    Text("Filter")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("APPLY"){
                        apply()
                        dismiss()
                    }
                    .tint(.indigo)
                    .font(.headline)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .disabled(isApplyDisabled)
                    
                }
            }
        }
    }
    

    
    private func clean() -> Void {
        if !isApplyDisabled {
            manager.getEpisodes(from: "page=1")
        }
        resetFilters()
    }
    
    private func resetFilters() {
        filter.name    = ""
        filter.episode = ""
    }
    
    private func apply() -> Void {
        manager.getEpisodesFiltered(by: filter)
    }
}

#Preview {
    FilterEpisodeView(
        filter: .constant(EpisodeFilter()),
        manager:     EpisodeOO()
    )
}
