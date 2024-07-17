//
//  EpisodeView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct EpisodeView: View {
    @StateObject var episodeViewModel = EpisodeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(Array(episodeViewModel.episodes.keys).sorted(), id: \.self) { season in
                        
                        Text(season)
                            .foregroundStyle(Color("Gray1"))
                            .fontWeight(.bold)
                            .font(.title3)
                            .padding(.top, 20)
                            .padding(.horizontal, 16)
                        
                        Divider()
                        
                        ForEach(episodeViewModel.episodes[season] ?? [], id: \.id) { item in
                            NavigationLink(destination: DetailView()) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.episode)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        
                                        Text(item.name)
                                            .font(.system(size: 15))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color.gray)
                                        
                                        Text(item.airDate)
                                            .font(.caption)
                                            .fontWeight(.regular)
                                            .foregroundColor(Color.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }.padding(.trailing, 16)
                            }
                            Divider()
                        }   .padding(.leading, 16)
                    }
                }
                .background(.white)
            }
            .padding(.top, 19)
            .navigationTitle("Episode")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    })
                    {
                        Text("Filter")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Indigo"))
                    }
                }
            }.background(Color("Gray7"))
            .onAppear{
                
                episodeViewModel.getEpisodes(from: "")
            }
        }
    }
}


#Preview {
    EpisodeView()
}
