//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI




struct FilterCharacter: View {
    
    @State private var isOn = false
    
    @Binding var status:      String
    @Binding var gender:      String
    @Binding var species:     String
    @Binding var name:        String
    @Binding var isPresented: Bool
    
    var manager: CharacterViewModel

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
                
                SearchItem(textToSearch: $name, title: "Name", placeholder:"Give a name")
                
                Divider()
                
                
                Divider()
                    .padding(.top, 15)
                
                SearchItem(textToSearch: $species, title: "Species", placeholder:"Select one")
                
                Divider()
                
                Text("Status")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray3)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                Divider()
                
                VStack(alignment:.leading, spacing: 10){
                    
                    EnumToggle(
                        selectedValue: $status,
                        toggleValue: Status.alive,
                        label: "Alive"
                    )
                 
                    EnumToggle(
                        selectedValue: $status,
                        toggleValue: Status.dead,
                        label: "Dead"
                    )
                    
                    EnumToggle(
                        selectedValue: $status,
                        toggleValue: Status.unknown,
                        label: "Unknown"
                    )
                    
                }.padding(.horizontal, 16)
                
                
                Text("Gender")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray3)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                Divider()
                
                VStack(alignment:.leading, spacing: 12){
                
                    EnumToggle(
                        selectedValue: $gender,
                        toggleValue: Gender.female,
                        label: "Female"
                    )

                    EnumToggle(
                        selectedValue: $gender,
                        toggleValue: Gender.male,
                        label: "Male"
                    )
                                        
                    EnumToggle(
                        selectedValue: $gender,
                        toggleValue: Gender.genderless,
                        label: "Genderless"
                    )
                    
                    EnumToggle(
                        selectedValue: $gender,
                        toggleValue: Gender.unknown,
                        label: "Unknown"
                    )

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
