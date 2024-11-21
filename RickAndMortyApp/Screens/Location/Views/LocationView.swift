//
//  LocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/7/24.
//

import SwiftUI



struct LocationView: View {
    
    @StateObject private var viewModel = LocationOO()
    
    @State private var isPresented: Bool   = false
    
    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Location", isFilterPresented: $isPresented)){
            ScrollView {
                LazyVGrid(columns: Constansts.gridLayout){
                    ForEach(viewModel.locations, id:\.id){ location in
                        NavigationLink(destination: LocationDetailView(locationId: location.id ?? 0)) {
                            card(location.type ?? "", location.name ?? "")
                        }
                    }
                }
                .padding(.top, 19)
                .padding(.horizontal, 16)
                .background(.white)
            }
        }
        .fullScreenCover(isPresented: $isPresented){
            FilterLocationView(
                manager: viewModel
            )
        }
    }
    
    private func card(_ type: String, _ name: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Group {
                Text(type)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.top, 12)
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .padding(.horizontal)
        
            Spacer()
        }
        .frame(width: 163, height: 80, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Gray5"), lineWidth: 1)
        )
    }
}



#Preview {
    LocationView()
}
