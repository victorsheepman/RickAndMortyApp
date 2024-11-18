//
//  FilterLocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI

struct FilterLocationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var name:        String
    @Binding var type:        String
    @Binding var dimension:   String
    
    var manager: LocationViewModel
    
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
                        //apply()
                        dismiss()
                        
                        manager.getLocationsFiltered(
                            name: name,
                            type: type,
                            dimension: dimension
                        )
                    }
                    .tint(.indigo)
                    .font(.headline)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    //.disabled(isApplyDisabled)
                    
                }
                
            }
        }
    }
    
    private func clean() -> Void {
        manager.getLocations(from: "page=3")
        name        = ""
        type        = ""
        dimension   = ""
    }
}

#Preview {
    FilterLocationView(
        name: .constant(""),
        type: .constant(""),
        dimension: .constant(""),
        manager: LocationViewModel() )
}
