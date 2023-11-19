//
//  CustomArView.swift
//  iOS-furniture-AR
//
//  Created by Mate Granic on 19.11.2023..
//

import ARKit
import RealityKit
import SwiftUI

class CusomArView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
}
