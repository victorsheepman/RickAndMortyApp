//
//  LocationCard.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 13/7/24.
//

import SwiftUI

struct LocationCard: View {
    
    @State var type: String
    @State var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(type)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.top, 10)
            
            Text(name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer()
        }
        .frame(width: 163, height: 80, alignment: .leading)
        .padding(.horizontal, 10)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Gray5"), lineWidth: 1)
        )
    }
}

#Preview {
    LocationCard(type: "Status", name: "PlanetBlue")
}
