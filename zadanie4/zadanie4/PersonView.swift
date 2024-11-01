//
//  PersonView.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import SwiftUI
import SwiftData

struct SinglePropertyView: View {
    @Environment(\.editMode) private var editMode
    
    var name: String
    var value: Binding<String>
    
    init(name: String, value: Binding<String>) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        GridRow {
            Text(name)
                .foregroundStyle(.secondary)
            
            if editMode?.wrappedValue.isEditing == true {
                TextField(name, text: value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 150)
            } else {
                Text(value.wrappedValue)
            }
        }
    }
}

struct PersonView: View {
    @State private var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 30, verticalSpacing: 10) {
            SinglePropertyView(name:"Name", value: $item.name)
            SinglePropertyView(name:"Surname", value: $item.surname)
//            SinglePropertyView(name:"Date of birth", value: $item.dateOfBirth)
            SinglePropertyView(name:"Phone", value: $item.phoneNumber)
            SinglePropertyView(name:"Email", value: $item.email)
            SinglePropertyView(name:"Address", value: $item.address)
        }
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}
