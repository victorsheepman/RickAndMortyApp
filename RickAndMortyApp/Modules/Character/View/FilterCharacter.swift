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
                header
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $name,
                    title: "Name",
                    placeholder:"Give a name"
                )
                
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $species,
                    title: "Species", 
                    placeholder:"Select one")
                
                Divider()
                
                statusSection
                
                genderSection
                
                Spacer()


            }
        }
    }
    
    private var header: some View {
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
            }
            .tint(.indigo)
            .font(.headline)
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .padding(.trailing, 20)
        }
    }
    
    private var statusSection: some View {
        VStack(alignment:.leading) {
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
        }
    }
    
    private var genderSection: some View {
        VStack(alignment:.leading) {
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
