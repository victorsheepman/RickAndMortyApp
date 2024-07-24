//
//  SearchItem.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 18/7/24.
//

import SwiftUI

struct SearchItem: View {
    @Binding var textToSearch: String
    let title: String
    let placeholder: String
    
    var body: some View {
        NavigationLink(destination: InputSearch(textToSearch: $textToSearch)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(placeholder)
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    SearchItem(textToSearch: .constant("''"), title: "Name", placeholder: "Give a name")
}
