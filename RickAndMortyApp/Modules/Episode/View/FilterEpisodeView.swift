//
//  FilterEpisodeView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 17/7/24.
//

import SwiftUI

struct FilterEpisodeView: View {
    
    @Binding var name:        String
    @Binding var episode:     String
    @Binding var isPresented: Bool
    
    var manager: EpisodeViewModel
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                HStack(alignment: .center){
                    
                    Button("Clear"){
                        cleanData()
                    }
                    .foregroundStyle(Color("Indigo"))
                    .font(.callout)
                    .fontWeight(.regular)
                    .padding(.leading, 20)
                    Spacer()
                    Text("Filter")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Black"))
                    Spacer()
                    Button("APPLY"){
                        manager.getEpisodesFiltered(name: name, episode: episode)
                        isPresented = false
                    }.frame(width:82, height:38)
                        .background(Color("Indigo"))
                        .cornerRadius(20)
                        .foregroundStyle(Color("White"))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.trailing, 20)
                }
                Divider()
                    .padding(.top, 15)
                
                NavigationLink(destination: Search(textToSearch: $name)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text("Give a name")
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }.padding(.horizontal, 16)
                Divider()
                Divider()
                    .padding(.top, 15)
                NavigationLink(destination: Search(textToSearch: $episode)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Episode")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text("Select One")
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }.padding(.horizontal, 16)
                
                Divider()
                
                
                Spacer()
                
            }
            
            
        }
    }
    
    private func cleanData() -> Void {
        manager.getEpisodes(from: "")
        name    = ""
        episode = ""
        isPresented = false
    }
}

#Preview {
    FilterEpisodeView(
        name:        .constant(""),
        episode:     .constant(""),
        isPresented: .constant(true),
        manager:     EpisodeViewModel()
    )
}
