//
//  ContentView.swift
//  iOS-furniture-AR
//
//  Created by Mate Granic on 14.11.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink(destination: ARScreenView()) {
                    Text("Visualization screen")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
