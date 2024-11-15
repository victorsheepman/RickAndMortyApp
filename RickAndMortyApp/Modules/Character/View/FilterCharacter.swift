//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI




struct FilterCharacter: View {
    
    @State private var isOn = false
    @Environment(\.dismiss) private var dismiss
    @State private var status: String = ""
    @Binding var gender:      String
    @Binding var species:     String
    @Binding var name:        String
    @Binding var isPresented: Bool
    
    @State var localGender: String = ""
    
    var manager: CharacterViewModel

    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
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


            }.onAppear {
                localGender = gender
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear"){
                        clean()
                    }
                    .tint(.indigo)
                }
                ToolbarItem(placement: .principal) {
                    Text("Filter")
                        .font(.title3)
                        .fontWeight(.semibold)
                        
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("APPLY"){
                       apply()
                    }
                    .tint(.indigo)
                    .font(.headline)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
    }
  
    private var statusSection: some View {
        VStack(alignment:.leading) {
            Text("Status")
                .font(.headline)
                .foregroundStyle(.gray2)
                .padding(.horizontal, 16)
                
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
                
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical)
    }
    
    private var genderSection: some View {
        VStack(alignment:.leading) {
            Text("Gender")
                .font(.headline)
                .foregroundStyle(.gray2)
                .padding(.horizontal, 16)
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
    
    
    private func clean() -> Void {
        gender      = ""
        status      = ""
        species     = ""
        name        = ""
        
        dismiss()
    }
    
    private func apply()->Void{
        gender = localGender
        manager.getCharacterFiltered(gender: gender, status: status, species: species, name:name)
        isPresented = false
    }
    
    
}

#Preview {
    FilterCharacter(
        gender:  .constant("unknown"),
        species: .constant(""),
        name:    .constant(""), 
        isPresented: .constant(false),
        manager: CharacterViewModel()
    )
}
