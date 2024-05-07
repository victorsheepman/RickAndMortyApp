//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var indice = 0
    @State var isDarkMode: Bool = false

    var body: some View {
        TabView(selection: $indice) {
            EpisodeView().tabItem {
                Text(Constansts.TabTitle.episode)
            }.tag(0).edgesIgnoringSafeArea(.top)
            CharacterView().tabItem {
                Text(Constansts.TabTitle.character)
            }.tag(1).edgesIgnoringSafeArea(.top)
            FavoriteView(isDarkMode: $isDarkMode).tabItem {
                Text(Constansts.TabTitle.favorite)
            }.tag(2).edgesIgnoringSafeArea(.top)
            SettingView(isDarkMode: $isDarkMode).tabItem {
                Text(Constansts.TabTitle.setting)
            }.tag(3).edgesIgnoringSafeArea(.top)
        }
    }
}

#Preview {
    ContentView()
}
