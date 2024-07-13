//
//  FavoriteView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct FavoriteView: View {
    
    @Binding var isDarkMode:Bool
   
    var body: some View {
        ZStack {
            isDarkMode ? Color("D") : Color.white
            Text("Favorite View")
                .foregroundStyle(isDarkMode ? .white : .black)
            
        }
      
    }
}

#Preview {
    FavoriteView(isDarkMode: .constant(false))
}
