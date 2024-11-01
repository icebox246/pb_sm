//
//  EditableTextView.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import SwiftUI
import SwiftData


struct PersonForm: View {
    @State private var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        Form {
            EditableTextView(name:"Name", value: $item.name)
            EditableTextView(name:"Surname", value: $item.surname)
            EditableDateView(name:"Date of birth", value: $item.dateOfBirth)
            EditableTextView(name:"Phone", value: $item.phoneNumber)
            EditableTextView(name:"Email", value: $item.email)
            EditableTextView(name:"Address", value: $item.address)
        }
    }
}

struct EditableTextView: View {
    @Environment(\.editMode) private var editMode
    var name: String
    var value: Binding<String>
    
    init(name: String, value: Binding<String>) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        LabeledContent(name) {
            if editMode?.wrappedValue.isEditing == true {
                TextField(name, text: value)
                    .frame(maxWidth: 200)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(value.wrappedValue)
            }
        }
    }
}

struct EditableDateView: View {
    @Environment(\.editMode) private var editMode
    var name: String
    var value: Binding<Date>
    
    init(name: String, value: Binding<Date>) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        if editMode?.wrappedValue.isEditing == true {
            DatePicker(name, selection: value, displayedComponents: [.date])
        } else {
            LabeledContent(name) {
                Text(value.wrappedValue.formatted(date:.abbreviated,time:.omitted))
            }
        }
        
    }
}
