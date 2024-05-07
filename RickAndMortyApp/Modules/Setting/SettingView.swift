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
            VStack{
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                        .foregroundStyle(isDarkMode ? .white : .black)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingView(isDarkMode: .constant(false))
}
