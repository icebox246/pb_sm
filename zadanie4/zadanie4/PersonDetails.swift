//
//  PersonView.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import SwiftUI
import SwiftData

struct PersonView: View {
    @State private var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        PersonForm(item: item)
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PersonView(item: Item(name: "Jan", surname: "Kowalski", dateOfBirth: Date.now, phoneNumber: "123456789", email: "foo@bar.baz", address: "Sezamkowa 21"))
    }
}
