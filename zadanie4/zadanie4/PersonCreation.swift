//
//  PersonCreation.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import SwiftUI

struct PersonCreation: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var item: Item
    @State private var editMode: EditMode = .active
    
    init() {
        self.item = Item(name: "", surname: "", dateOfBirth: Date.now, phoneNumber: "", email: "", address: "")
    }
    
    var body: some View {
        PersonForm(item: item)
            .environment(\.editMode, $editMode)
            .navigationTitle("Create Person")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: saveItem, label: {
                        Text("Create")
                    })
                    .disabled(!item.isValid)
                }
            }
    }
    
    func saveItem() {
        modelContext.insert(item)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        PersonCreation()
    }
}
