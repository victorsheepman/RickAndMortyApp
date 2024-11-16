//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI




struct FilterCharacter: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filters: CharacterFilters
    
    var manager: CharacterViewModel
    
    private var isApplyDisabled: Bool {
        [filters.status, filters.gender, filters.species, filters.name]
            .allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                SearchItem(
                    textToSearch: $filters.name,
                    title: "Name",
                    placeholder:"Give a name"
                )
                
                Divider()
                    .padding(.top, 15)
                
                SearchItem(
                    textToSearch: $filters.species,
                    title: "Species",
                    placeholder:"Select one")
                
                Divider()
                
                statusSection
                
                genderSection
                
                Spacer()
                
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear"){
                        clean()
                        dismiss()
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
                        dismiss()
                    }
                    .tint(.indigo)
                    .font(.headline)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .disabled(isApplyDisabled)
                    
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
                    selectedValue: $filters.status,
                    toggleValue: Status.alive,
                    label: "Alive"
                )
                
                EnumToggle(
                    selectedValue: $filters.status,
                    toggleValue: Status.dead,
                    label: "Dead"
                )
                
                EnumToggle(
                    selectedValue: $filters.status,
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
                    selectedValue: $filters.gender,
                    toggleValue: Gender.female,
                    label: "Female"
                )
                
                EnumToggle(
                    selectedValue: $filters.gender,
                    toggleValue: Gender.male,
                    label: "Male"
                )
                
                EnumToggle(
                    selectedValue: $filters.gender,
                    toggleValue: Gender.genderless,
                    label: "Genderless"
                )
                
                EnumToggle(
                    selectedValue: $filters.gender,
                    toggleValue: Gender.unknown,
                    label: "Unknown"
                )
                
            }.padding(.horizontal, 16)
        }
    }
    
    private func clean() -> Void {
        if !isApplyDisabled {
            manager.getCharacters(from: "page=19")
        }
        resetFilters()
    }
    
    private func resetFilters() {
        filters.gender = ""
        filters.status = ""
        filters.species = ""
        filters.name = ""
    }
    
    private func apply()->Void{
        manager.getCharacterFiltered(
            gender: filters.gender,
            status: filters.status,
            species: filters.species,
            name: filters.name
        )
    }
}

#Preview {
    FilterCharacter(
        filters: .constant(CharacterFilters(status: "", gender: "", species: "", name: "")),
        manager: CharacterViewModel()
    )
}
