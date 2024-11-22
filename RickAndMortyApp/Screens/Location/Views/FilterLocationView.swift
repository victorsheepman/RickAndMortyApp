//
//  FilterLocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI

struct FilterLocationView: View {
    @Environment(\.dismiss) private var dismiss
        
    @SceneStorage("nameFilterLocation") private var name: String = ""
    @SceneStorage("typeFilterLocation") private var type: String = ""
    @SceneStorage("dimensionFilterLocation") private var dimension: String = ""
 
    var manager: LocationOO
    
    private var isApplyDisabled: Bool {
        [type, dimension, name]
            .allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                Divider()
                SearchItem(
                    textToSearch: $name,
                    title: "Name",
                    placeholder: "Give a name"
                )
                
                Divider()
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $type,
                    title: "Type",
                    placeholder: "Select one"
                )
                
                Divider()
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $dimension,
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
        if !isApplyDisabled {
            manager.getLocations(from: "page=2")
        }
        resetFilter()
    }
    
    private func resetFilter() {
        name = ""
        type = ""
        dimension = ""
    }
    
    private func apply() -> Void {
        let filter = LocationFilter(
            name: name,
            type: type,
            dimension: dimension
        )
        manager.getLocationsFiltered(by: filter)
    }
}

#Preview {
    FilterLocationView(
        manager: LocationOO()
    )
}
