//
//  HeaderView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//

import SwiftUI

struct HeaderView: View {
    
    var caption: String
    var title: String
    var footnote: String
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color("Gray6"))
                .frame(width: geometry.size.width)
                .overlay {
                    VStack {
                        Text(caption)
                            .font(.caption2)
                            .foregroundStyle(.gray2)
                        
                        Text(title)
                            .font(.title.bold())
                        
                        Text(footnote)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray1)
                    }
                }
        }
        .frame(minHeight: 105, maxHeight: 139)
        .padding(.top, -50)
    }
}

