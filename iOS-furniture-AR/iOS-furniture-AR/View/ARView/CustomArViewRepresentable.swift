//
//  CustomArViewRepresentable.swift
//  iOS-furniture-AR
//
//  Created by Mate Granic on 19.11.2023..
//

import SwiftUI

struct CusomArViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return CusomArView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
