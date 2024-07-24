//
//  HeaderContainer.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 22/7/24.
//

import SwiftUI

struct HeaderContainerConfiguration {
    let title: String
    let isFilterPresented: Binding<Bool>
}

struct HeaderContainer<Content: View>: View {
    
    let config: HeaderContainerConfiguration
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        NavigationView {
            ScrollView {
                content()
            }
            .padding(.top, 19)
            .navigationTitle(config.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        config.isFilterPresented.wrappedValue = true
                    })
                    {
                        Text("Filter")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Indigo"))
                    }
                }
            }
            .background(Color("Gray7"))
        }
    }
}

#Preview {
    HeaderContainer(config: .init(title: "holas", isFilterPresented: .constant(false))) {
        Text("hola")
    }
}

