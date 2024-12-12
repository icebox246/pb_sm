//
//  ContentView.swift
//  KwikLoc
//
//  Created by Adam on 07/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HStack {
                    Image(systemName: "location.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("KwikLoc").font(.system(size: 30))
                }
                .padding()
                
                Text("Wybierz kategorię miejsc")
                .padding()
                
                Spacer()
                
                VStack {
                    ForEach(Category.allCases) { category in
                        NavigationLink {
                            DistancePickerView(category: category)
                        } label: {
                            Label(category.data.0, image: category.data.2)
                        }
                    }.padding()
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
