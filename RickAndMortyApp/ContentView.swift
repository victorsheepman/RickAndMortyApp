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
            CharacterView().tabItem {
                Image(indice ==  0 ? "ghost-active" : "ghost")
                   
                Text(Constansts.TabTitle.character)
            }.tag(0).edgesIgnoringSafeArea(.top)
            LocationView().tabItem {
                Image(indice ==  1 ? "planet-active" : "planet")
                Text(Constansts.TabTitle.location)
            }.tag(1).edgesIgnoringSafeArea(.top)
            EpisodeView().tabItem {
                Image(indice ==  2 ? "tv-active" : "tv")
                Text(Constansts.TabTitle.episode)
            }.tag(2).edgesIgnoringSafeArea(.top)
           
          
        }.accentColor(Color("Indigo"))
    }
}

#Preview {
    ContentView()
}
