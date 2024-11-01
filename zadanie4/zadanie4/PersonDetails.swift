//
//  PersonView.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import SwiftUI
import SwiftData

struct PersonDetails: View {
    @Environment(\.editMode) private var editMode
    
    private var item: Item
    private var workingItem: Item
    
    init(item: Item) {
        self.item = item
        
        workingItem = Item(name: "", surname: "", dateOfBirth: Date.now, phoneNumber: "", email: "", address: "")
        workingItem.setFrom(item)
    }
    
    var body: some View {
        PersonForm(item: workingItem)
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if editMode?.wrappedValue.isEditing ?? false {
                    Button {
                        item.setFrom(workingItem)
                        editMode?.wrappedValue = .inactive
                    } label: {
                        Text("Save")
                    }.disabled(!workingItem.isValid)
                } else {
                    Button {
                        editMode?.wrappedValue = .active
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }.onAppear {
            workingItem.setFrom(item)
        }
    }
}
