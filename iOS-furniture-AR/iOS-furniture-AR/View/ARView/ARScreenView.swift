//
//  ArVisualizationView.swift
//  iOS-furniture-AR
//
//  Created by Mate Granic on 19.11.2023..
//

import SwiftUI

struct ARScreenView: View {
    var body: some View {
        ARViewRepresentable()
            //.ignoresSafeArea()
    }
}

struct ArVisualizationView_Previews: PreviewProvider {
    static var previews: some View {
        ARScreenView()
    }
}
