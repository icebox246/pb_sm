//
//  Item.swift
//  zadanie4
//
//  Created by Adam on 01/11/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var name: String
    var surname: String
    var dateOfBirth: Date
    var phoneNumber: String
    var email: String
    var address: String
    
    init(name: String, surname: String, dateOfBirth: Date, phoneNumber: String, email: String, address: String) {
        self.name = name
        self.surname = surname
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
    }
}
