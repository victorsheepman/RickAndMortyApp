//
//  FilterLocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI

struct FilterLocationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filter: LocationFilter
    
    var manager: LocationOO
    
    private var isApplyDisabled: Bool {
        [filter.name, filter.type, filter.dimension]
            .allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                Divider()
                SearchItem(
                    textToSearch: $filter.name,
                    title: "Name",
                    placeholder: "Give a name"
                )
                
                Divider()
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $filter.type,
                    title: "Type",
                    placeholder: "Select one"
                )
                
                Divider()
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $filter.dimension,
                    title: "Dimension",
                    placeholder: "Select one"
                )
                Divider()
                Spacer()
            }
            .toolbar {
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
        manager.getLocations(from: "page=3")
        resetFilter()
    }
    
    private func resetFilter() {
        filter.name = ""
        filter.type = ""
        filter.dimension = ""
    }
    
    private func apply() -> Void {
        manager.getLocationsFiltered(by: filter)
    }
}

#Preview {
    FilterLocationView(
        filter:.constant(LocationFilter(name: "", type: "", dimension: "")),
        manager: LocationOO()
    )
}
