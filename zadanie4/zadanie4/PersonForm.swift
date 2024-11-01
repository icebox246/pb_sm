//
//  EditableTextView.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import SwiftUI
import SwiftData


struct PersonForm: View {
    @State var item: Item
    
    var body: some View {
        Form {
            EditableTextView(name:"Name", value: ($item.name))
            EditableTextView(name:"Surname", value: ($item.surname))
            EditableDateView(name:"Date of birth", value: ($item.dateOfBirth))
            EditableTextView(name:"Phone", value: ($item.phoneNumber))
            EditableTextView(name:"Email", value: ($item.email))
            EditableTextView(name:"Address", value: ($item.address))
            
            if !item.isValid {
                Section("Errors") {
                    ForEach(item.getErrors(), id: \.self) { error in
                        Text(error)
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

struct EditableTextView: View {
    @Environment(\.editMode) private var editMode
    var name: String
    @Binding var value: String
    
    var body: some View {
        LabeledContent(name) {
            if editMode?.wrappedValue.isEditing == true {
                TextField(name, text: $value)
                    .frame(maxWidth: 200)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(value)
            }
        }
    }
}

struct EditableDateView: View {
    @Environment(\.editMode) private var editMode
    var name: String
    @Binding var value: Date
    
    var body: some View {
        if editMode?.wrappedValue.isEditing == true {
            DatePicker(name, selection: $value, displayedComponents: [.date])
        } else {
            LabeledContent(name) {
                Text(value.formatted(date:.abbreviated,time:.omitted))
            }
        }
    }
}
