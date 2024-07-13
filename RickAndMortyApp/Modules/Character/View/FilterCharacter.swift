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
    var id =     UUID()
    let title:   String
    let caption: String
}

struct FilterCharacter: View {
    
    @State private var isOn = false
    
    @Binding var status:      String
    @Binding var gender:      String
    @Binding var species:     String
    @Binding var name:        String
    @Binding var isPresented: Bool
    
    var manager: CharacterViewModel
    
    let links:[FilterLink] = [
        FilterLink(title: "Name", caption: "Give a name")
    ]
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
                        manager.getCharacterFiltered(gender: gender, status: status, species: species, name:name)
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
                NavigationLink(destination: Search(textToSearch: $species)) {
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
                        get: { status == Status.alive.rawValue },
                        set: { if $0 { status = Status.alive.rawValue } })
                    ) {
                        Text("Alive")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }.toggleStyle(iOSRadioButtonToggleStyle())
                   
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { status == Status.dead.rawValue },
                        set: { if $0 { status = Status.dead.rawValue } })
                    ) {
                        Text("Dead")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                    
                    
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { status == Status.unknown.rawValue },
                        set: { if $0 { status = Status.unknown.rawValue } })
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
                        get: { gender == Gender.female.rawValue },
                        set: { if $0 { gender = Gender.female.rawValue } })
                    ) {
                        Text("Female")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == Gender.male.rawValue },
                        set: { if $0 { gender = Gender.male.rawValue } })
                    ) {
                        Text("Male")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                   
                 
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == Gender.genderless.rawValue },
                        set: { if $0 { gender = Gender.genderless.rawValue } })
                    ) {
                        Text("Genderless")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .toggleStyle(iOSRadioButtonToggleStyle())
                    
                    Toggle(isOn: Binding<Bool>(
                        get: { gender == Gender.unknown.rawValue },
                        set: { if $0 { gender = Gender.unknown.rawValue } })
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
    
    private func cleanData() -> Void {
        manager.getCharacters(from: "page=19")
        gender      = ""
        status      = ""
        species     = ""
        name        = ""
        isPresented = false
        

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
    FilterCharacter(
        status:  .constant("unknown"),
        gender:  .constant("unknown"),
        species: .constant(""),
        name:    .constant(""), 
        isPresented: .constant(false),
        manager: CharacterViewModel()
    )
}
