//
//  LocationDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI

struct LocationDetailView: View {
    
    @StateObject var locationDetailViewModel = LocationDetailViewModel()
    
    var locationId: Int
    var residents: [String]
    
    var residentIds: [Int] {
        return residents.compactMap { url in
            return url.split(separator: "/").last.flatMap { Int($0) }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                           VStack {
                               Rectangle()
                                   .fill(Color("Gray6"))
                                   .frame(width: geometry.size.width, height: 139)
                                   .overlay {
                                       VStack {
                                           Text(locationDetailViewModel.location?.type ?? "")
                                               .font(.caption)
                                               .fontWeight(.regular)
                                               .foregroundStyle(.gray2)
                                           
                                           Text(locationDetailViewModel.location?.name ?? "")
                                               .font(.title2)
                                               .fontWeight(.bold)
                                           
                                           Text(locationDetailViewModel.location?.dimension ?? "")
                                               .font(.subheadline)
                                               .fontWeight(.medium)
                                               .foregroundStyle(.gray1)
                                       }
                                   }
    
                           }
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                       }
             
            }
            .onAppear{
                locationDetailViewModel.getLocation(from: locationId)
            }
            Spacer()
        }
    }
}

#Preview {
    LocationDetailView(locationId: 3, residents: [
        "https://rickandmortyapi.com/api/character/8",
        "https://rickandmortyapi.com/api/character/14"
      ])
}
