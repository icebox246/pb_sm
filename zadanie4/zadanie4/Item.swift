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
    
    func setFrom(_ item: Item) {
        name = item.name
        surname = item.surname
        dateOfBirth = item.dateOfBirth
        phoneNumber = item.phoneNumber
        email = item.email
        address = item.address
    }
    
    func getErrors() -> [String] {
        var errors: [String] = []
        if name.isEmpty { errors.append("Name is required") }
        if surname.isEmpty { errors.append("Surname is required") }
        if phoneNumber.isEmpty { errors.append("Phone number is required") }
        else if phoneNumber.matches(of: /^[+]?(\d{2})?(\s?\d{3}){3}$/).isEmpty { errors.append("Phone number is incorrect") }
        if email.isEmpty { errors.append("Email address is required") }
        else if email.matches(of: /^\w+@\w+\.\w+$/).isEmpty { errors.append("Email address is incorrect") }
        if address.isEmpty { errors.append("Address is required") }
        return errors
    }
    
    var isValid: Bool {
        getErrors().isEmpty
    }
    
    func copy() -> Self {
        let res = Self(name: name, surname: surname, dateOfBirth: dateOfBirth, phoneNumber: phoneNumber, email: email, address: address)
        return res
    }
}
