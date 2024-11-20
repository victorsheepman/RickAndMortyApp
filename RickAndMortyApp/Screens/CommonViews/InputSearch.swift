//
//  InputSearch.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 18/7/24.
//

import SwiftUI



struct InputSearch: View {
    @Binding var textToSearch:String
   
    @State private var isSearching: Bool = false
    var body: some View {
        HStack {
                    TextField(
                        "Search",
                        text: $textToSearch
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .textInputAutocapitalization(.none)
                    .disableAutocorrection(true)
                    .onTapGesture {
                        isSearching = true
                    }
                    .onChange(of: textToSearch) { newValue in
                        textToSearch = newValue.lowercased()
                    }
                    
                    if isSearching {
                        Button(action: {
                            isSearching = false
                           
                        }) {
                            Text("Cancel")
                                .foregroundColor(.blue)
                                .padding(.trailing, 8)
                        }
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                .padding(.horizontal)
        Spacer()
    }
}




#Preview {
    InputSearch(textToSearch: .constant(""))
}
