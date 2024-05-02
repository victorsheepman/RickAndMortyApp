//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var indice = 0
    var body: some View {
        TabView(selection: $indice) {
            EpisodeView().tabItem {
                Text("Episodios")
            }.tag(0).edgesIgnoringSafeArea(.top)
            CharacterView().tabItem {
                Text("Personajes")
            }.tag(1).edgesIgnoringSafeArea(.top)
            FavoriteView().tabItem {
                Text("Favoritos")
            }.tag(2).edgesIgnoringSafeArea(.top)
            SettingView().tabItem {
                Text("Favoritos")
            }.tag(3).edgesIgnoringSafeArea(.top)
        }
    }
}

#Preview {
    ContentView()
}
