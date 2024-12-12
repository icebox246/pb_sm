//
//  SearchResultsView.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

import SwiftUI
import CoreLocation

struct SearchResultsView: View {
    var category: Category
    var maxDistance: Double
    @Binding var location: CLLocation?
    @StateObject var model = SearchResultsModel()
    
    var body: some View {
        VStack {
            if location == nil {
                Text("Nie udało się uzyskać aktualnej lokalizacji")
            } else {
                if model.loading {
                    ProgressView()
                    Text("Ładowanie wyników...")
                }
                List(model.results) { result in
                    NavigationLink {
                        MapView(target: CLLocationCoordinate2D(latitude: result.lat, longitude: result.lon), location: location?.coordinate ?? CLLocationCoordinate2D())
                    } label: {
                        VStack(alignment: .leading) {
                            if result.name != nil {
                                Text("\(result.name!)")
                                    .font(.system(size: 20))
                                    .bold()
                                Text("\(result.address)")
                            } else {
                                Text("\(result.address)")
                                    .font(.system(size: 20))
                                    .bold()
                            }
                            Text("\(result.distance.formatted())m")
                                .italic()
                        }
                    }
                    .isDetailLink(true)
                    .navigationTitle("Wyniki wyszukiwania")
                    
                }.onAppear {
                    if model.results.isEmpty {
                        model.fetchResults(category: category, maxDistance: maxDistance, location: location!)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}
