//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI


struct FilterCharacterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @SceneStorage("statusCharacter") var status: String = ""
    @SceneStorage("genderCharacter") var gender: String = ""
    @SceneStorage("speciesCharacter") var species: String = ""
    @SceneStorage("nameCharacter") var name: String = ""
    
    var manager: CharacterOO
    
    private var isApplyDisabled: Bool {
        [status, gender, species, name]
            .allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
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
                ForEach(Status.allCases, id: \.hashValue) { status in
                    EnumToggle(
                        selectedValue: $status,
                        toggleValue: status,
                        label: status.rawValue.capitalized
                    )
                }
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
                ForEach(Gender.allCases, id: \.hashValue) { gender in
                    EnumToggle(
                        selectedValue: $gender,
                        toggleValue: gender,
                        label: gender.rawValue.capitalized
                    )
                }
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
        gender = ""
        status = ""
        species = ""
        name = ""
    }
    
    private func apply() -> Void {
        var filter = CharacterFilter(status: status, gender: gender, species: species, name: name)
        manager.getCharacterFiltered(by: filter)
    }
}

#Preview {
    FilterCharacterView(
        manager: CharacterOO()
    )
}
