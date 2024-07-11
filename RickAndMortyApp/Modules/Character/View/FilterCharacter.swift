//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI

enum Status: String {
    case dead    = "dead"
    case alive   = "alive"
    case unknown = "unknown"
}

enum Gender: String {
    case male       = "male"
    case female     = "female"
    case unknown    = "unknown"
    case genderless = "genderless"

}


struct FilterLink: Identifiable {
    var id = UUID()
    
    let title: String
    let caption: String
}

struct FilterCharacter: View {
    
    @State private var isOn = false
    
    @State private var currentStatus: Status = .alive
    @State private var status: Status        = .unknown
    @State private var gender: Gender        = .unknown
    
    let links:[FilterLink] = [
        FilterLink(title: "Name", caption: "Give a name")
    ]
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                HStack(alignment: .center){
                    
                    Button("Clear"){
                        
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
                NavigationLink(destination: Search()) {
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
                NavigationLink(destination: Search()) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Species")
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    
                                    Text("Select one")
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
                
                Text("Status")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray3)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                Divider()
                
                VStack(alignment:.leading, spacing: 10){
                    Toggle(isOn: Binding<Bool>(
                        get: { status == .alive },
                        set: { if $0 { status = .alive } })
                    ) {
                        Text("Alive")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }.toggleStyle(iOSRadioButtonToggleStyle())
                   
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { status == .dead },
                        set: { if $0 { status = .dead } })
                    ) {
                        Text("Dead")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                    
                    
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { status == .unknown },
                        set: { if $0 { status = .unknown } })
                    ) {
                        Text("Unknown")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
               
                    
                }.padding(.horizontal, 16)
                
                
                Text("Gender")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray3)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                Divider()
                
                VStack(alignment:.leading, spacing: 12){
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == .female },
                        set: { if $0 { gender = .female } })
                    ) {
                        Text("Female")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == .male },
                        set: { if $0 { gender = .male } })
                    ) {
                        Text("Male")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                   
                 
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == .genderless },
                        set: { if $0 { gender = .genderless } })
                    ) {
                        Text("Genderless")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == .unknown },
                        set: { if $0 { gender = .unknown } })
                    ) {
                        Text("Unknown")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())

                }.padding(.horizontal, 16)
                
          
                
               
                Spacer()


            }
            
           
            
            
           

        }
    }
}

extension Binding where Value == Status {
    var isAlive: Binding<Bool> {
        return Binding<Bool>(
            get: { self.wrappedValue == .alive },
            set: { self.wrappedValue = $0 ? .alive : .dead }
        )
    }
}




struct Search: View {
    var body: some View {
        Text("Detail View")
            .font(.largeTitle)
            .navigationTitle("Details")
    }
}

#Preview {
    FilterCharacter()
}
