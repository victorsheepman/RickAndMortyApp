//
//  EpisodeCard.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 20/7/24.
//

import SwiftUI

struct EpisodeCard: View {
    var episode: String
    var id:      Int
    var name:    String
    var airDate: String
    
    var body: some View {
        NavigationLink(destination: EpisodeDetailView(episodeId: id)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(episode)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Group {
                        Text(name)
                            .font(.callout)
      
                        Text(airDate)
                            .font(.caption)
                    }
                    .foregroundStyle(.gray)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    EpisodeCard(
        episode: "S03E07",
        id: 28,
        name: "The Ricklantis Mixup",
        airDate:  "September 10, 2017"
    )
}
