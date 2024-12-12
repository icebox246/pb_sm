//
//  CategoryDisplay.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

import SwiftUI

struct CategoryDisplay: View {
    var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var body: some View {
        HStack{
            Image(systemName: "location")
            Text(category.data.0)
        }
    }
}
