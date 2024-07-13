//
//  SettingView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct SettingView: View {
   @Binding var isDarkMode: Bool
    var body: some View {
        ZStack {
            isDarkMode ? Color("D") : Color.white
            VStack(spacing:20){
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                        .foregroundStyle(isDarkMode ? .white : .black)
                }
                HStack{
                    Text("Delete Favorite")
                        .foregroundStyle(isDarkMode ? .white : .black)
                    Spacer()
                    Button(action: {
                        print("Eliminar Favoritos!!!!")
                    }, label: {
                        Text("Delete")
                    })
                    .foregroundStyle(.red)
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingView(isDarkMode: .constant(false))
}
