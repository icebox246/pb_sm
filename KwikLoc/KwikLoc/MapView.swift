//
//  MapView.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

import SwiftUI
import MapboxMaps

struct MapView: View {
    var target: CLLocationCoordinate2D
    var location: CLLocationCoordinate2D
    
    private class MyLocationProvider {
        @Published var location: Location
        @Published var heading = Heading(direction: 0, accuracy: 0)
        
        init(location: Location) {
            self.location = location
        }
    }
    @State private var provider: MyLocationProvider
    
    init(target: CLLocationCoordinate2D, location: CLLocationCoordinate2D) {
        self.target = target
        self.location = location
        provider = MyLocationProvider(location: Location(coordinate: location))
    }
    
    var body: some View {
        MapReader { proxy in
            Map(initialViewport: .camera(center: location, zoom: 16, bearing: 0, pitch: 30)) {
                PolylineAnnotation(lineCoordinates: [ location, target ])
                    .lineColor(.red)
                    .lineWidth(6)
                    .lineBorderColor(.white)
                    .lineBorderWidth(2)
                
                CircleAnnotation(centerCoordinate: target)
                    .circleColor(.red)
                    .circleRadius(7)
                    .circleStrokeColor(.white)
                    .circleStrokeWidth(2)

                Puck2D()
            }
            .onAppear {
                proxy.location?.override(
                    locationProvider: provider.$location.map { [$0] }.eraseToSignal())
            }
//            .ignoresSafeArea()
        }}
}
