//
//  EnumToggle.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 18/7/24.
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

struct EnumToggle<T: RawRepresentable & Equatable>: View where T.RawValue == String {
    
    @Binding var selectedValue: String
    
    let toggleValue: T
    let label: String
    
    var body: some View {
        Toggle(isOn: Binding<Bool>(
            get: { selectedValue == toggleValue.rawValue },
            set: { if $0 { selectedValue = toggleValue.rawValue } }
        )) {
            Text(label)
                .font(.title3)
                .fontWeight(.regular)
                .foregroundColor(.black)
        }
        .toggleStyle(iOSRadioButtonToggleStyle())
    }
}

#Preview {
    EnumToggle(
        selectedValue: .constant("genderless"),
        toggleValue: Gender.genderless,
        label: "Genderless"
    )
}
