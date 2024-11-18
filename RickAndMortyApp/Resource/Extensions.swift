//
//  Extensions.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 18/11/24.
//

import Foundation


extension CharacterDataModel {
    func toSections() -> [RowItem] {
        return [
            RowItem(title: "Name", value: name),
            RowItem(title: "Status", value: status),
            RowItem(title: "Species", value: species),
            RowItem(title: "Type", value: type.isEmpty ? "Unknown" : type),
            RowItem(title: "Gender", value: gender),
            RowItem(title: "Location", value: location.name)
        ]
    }
}
