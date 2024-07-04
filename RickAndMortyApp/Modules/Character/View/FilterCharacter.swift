//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI



struct FilterLink: Identifiable {
    var id = UUID()
    
    let title: String
    let caption: String
}

struct FilterCharacter: View {
    let links:[FilterLink] = [
        FilterLink(title: "Name", caption: "Give a name")
    ]
    var body: some View {
        NavigationView{
            VStack{
                HStack(alignment: .center){
                    Spacer()
                    Spacer()
                    Text("Filter")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Black"))
                    Spacer()
                    Button("APPLY"){
                        
                    }.frame(width:82, height:38)
                    .background(Color("Indigo"))
                    .cornerRadius(20)
                    .foregroundStyle(Color("White"))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.trailing, 20)
                }
                
                List {
                    ForEach(links){ l in
                        NavigationLink(l.title){
                            
                        }
                    }
                }
            }
           

        }
    }
}

#Preview {
    FilterCharacter()
}
