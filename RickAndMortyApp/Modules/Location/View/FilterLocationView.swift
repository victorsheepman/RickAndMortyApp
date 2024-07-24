//
//  FilterLocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI

struct FilterLocationView: View {
    
    @Binding var name:        String
    @Binding var type:        String
    @Binding var dimension:   String
    @Binding var isPresented: Bool
    
    var manager: LocationViewModel
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                HStack(alignment: .center){
                    Button("Clear"){
                        cleanData()
                    }
                    .foregroundStyle(Color("Indigo"))
                    .font(.callout)
                    .fontWeight(.regular)
                    .padding(.leading, 20)
                    Spacer()
                    Text("Filter")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Black"))
                    Spacer()
                    Button("APPLY"){
                        manager.getLocationsFiltered(
                            name: name,
                            type: type,
                            dimension: dimension
                        )
                        isPresented = false
                    }.frame(width:82, height:38)
                        .background(Color("Indigo"))
                        .cornerRadius(20)
                        .foregroundStyle(Color("White"))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.trailing, 20)
                }
                Divider()
                    .padding(.top, 15)
             
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
        }
    }
    
    private func cleanData() -> Void {
        manager.getLocations(from: "page=3")
        name        = ""
        type        = ""
        dimension   = ""
        isPresented = false
    }
}

#Preview {
    FilterLocationView(
        name: .constant(""),
        type: .constant(""),
        dimension: .constant(""), 
        isPresented: .constant(true),
        manager: LocationViewModel() )
}
