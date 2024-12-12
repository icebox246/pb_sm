//
//  Category.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

enum Category: CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    var data: (String, String, String) {
        switch self {
            case .fastFood: return ("Fast Food", "catering.fast_food", "kebab_dining_24dp")
            case .restaurant: return ("Restauracja", "catering.restaurant", "ramen_dining_24dp")
            case .convenienceStore: return ("Sklep całodobowy", "commercial.convenience", "local_convenience_store_24dp")
            case .pharmacy: return ("Apteka", "healthcare.pharmacy", "local_pharmacy_24dp")
        }
    }
    
    case fastFood
    case restaurant
    case convenienceStore
    case pharmacy
}
