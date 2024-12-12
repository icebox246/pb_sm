//
//  SearchResultsModel.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

import Foundation
import Combine
import CoreLocation

struct SearchResult: Codable, Identifiable {
    let name: String?
    let lon: Double
    let lat: Double
    let formatted: String
    let distance: Float
    
    var id: String {
       "\(name ?? "") \(lon) \(lat)"
    }
    
    var address: String {
       formatted
    }
}

class SearchResultsModel: ObservableObject {
    @Published var results: [SearchResult] = []
    @Published var loading: Bool = false
    
    private struct Response: Codable {
        let features: [Feature]
        
        struct Feature: Codable {
            let properties: SearchResult
        }
    }

    func fetchResults(category: Category, maxDistance: Double, location: CLLocation) {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return }
        guard let geoapifyAccessToken: String = infoDictionary["GEOAPIFY_KEY"] as? String else { return }
        
        loading = true

        guard let url = URL(string: "https://api.geoapify.com/v2/places?categories=\(category.data.1)&filter=circle:\(location.coordinate.longitude),\(location.coordinate.latitude),\(maxDistance * 1000)&bias=proximity:\(location.coordinate.longitude),\(location.coordinate.latitude)&lang=pl&limit=10&apiKey=\(geoapifyAccessToken)") else {return }

        print(#function, url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
            
                let results = response.features.map({ feature in
                    feature.properties
                })
                
                DispatchQueue.main.async {
                    self.results = results
                    self.loading = false
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
