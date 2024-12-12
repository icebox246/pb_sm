//
//  DistancePickerView.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

import SwiftUI

struct DistancePickerView: View {
    var category: Category
    @StateObject var locationManager = LocationManager()

    @State var maxDistance = 1.0
    
    init(category: Category) {
        self.category = category
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Wybierz maksymalną odległość")
                .padding()
            
            Spacer()
            
            VStack {
                Text("\(maxDistance.formatted()) km").font(.system(size: 30))
                Slider(value: $maxDistance, in: 0.5...2.5, step: 0.5)
            }
            .padding()
            
            NavigationLink {
                SearchResultsView(category: category, maxDistance: maxDistance, location: $locationManager.lastLocation)
            } label: {
                Label("Dalej", systemImage: "magnifyingglass")
            }
            .padding()
            .disabled(locationManager.locationStatus == .denied)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .navigationTitle(category.data.0)
    }
}

#Preview {
    DistancePickerView(category: .convenienceStore)
}
