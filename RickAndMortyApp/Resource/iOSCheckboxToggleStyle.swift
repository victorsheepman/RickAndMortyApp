//
//  iOSCheckboxToggleStyle.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 11/7/24.
//

import Foundation
import SwiftUI

struct iOSRadioButtonToggleStyle: ToggleStyle {
    var onColor:  Color = Color("Indigo")
    var offColor: Color = Color.gray1
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(configuration.isOn ? onColor : offColor)
                configuration.label
            }
        })
    }
}
