//
//  FilterCharacter.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI

struct CharacterFilter {
    var status = String()
    var gender = String()
    var species = String()
    var name = String()
}

struct FilterCharacterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @SceneStorage("statusCharacter") var selectedStatus: String = ""
    @SceneStorage("genderCharacter") var selectedGender: String = ""
    @SceneStorage("speciesCharacter") var species: String = ""
    @SceneStorage("nameCharacter") var name: String = ""
    
    var manager: CharacterOO
    
    private var isApplyDisabled: Bool {
        [selectedStatus, selectedGender, species, name]
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
                
                List {
                    Section(header: sectionHeader("Status")) {
                        ForEach(Status.allCases, id: \.hashValue) { status in
                            EnumToggle(
                                selectedValue: $selectedStatus,
                                toggleValue: status,
                                label: status.rawValue.capitalized
                            )
                        }
                    }
                    Section(header: sectionHeader("Gender")){
                        ForEach(Gender.allCases, id:\.hashValue) { gender in
                            EnumToggle(
                                selectedValue: $selectedGender,
                                toggleValue: gender,
                                label: gender.rawValue.capitalized
                            )
                        }
                    }
                }.listStyle(.plain)
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
    
    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.title3.bold())
            .foregroundStyle(.gray)
    }
    
    private func clean() -> Void {
        if !isApplyDisabled {
            manager.getCharacters(from: "page=19")
        }
        resetFilters()
    }
    
    private func resetFilters() {
        selectedGender = ""
        selectedStatus = ""
        species = ""
        name = ""
    }
    
    private func apply() -> Void {
        let filter = CharacterFilter(
            status: selectedStatus,
            gender: selectedGender,
            species: species,
            name: name
        )
        manager.getCharacterFiltered(by: filter)
    }
}

#Preview {
    FilterCharacterView(
        manager: CharacterOO()
    )
}
