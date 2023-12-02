//
//  CustomArView.swift
//  iOS-furniture-AR
//
//  Created by Mate Granic on 19.11.2023..
//

import ARKit
import RealityKit
import SwiftUI

class CustomARView: ARView {
    
    private var frameRectGlobal: CGRect
    private var anchorGlobal: AnchorEntity?
    
    required init(frame frameRect: CGRect) {
        self.frameRectGlobal = frameRect
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        addGestureRecognizer(tapGestureRecognizer)
        
        
        placeEntityIntoScene()
    }
    
    func placeEntityIntoScene(at position: SCNVector3? = nil) {
        // create 3D model
        //let box = MeshResource.generateBox(size: 0.1)
        let sphere = MeshResource.generateSphere(radius: 0.1)
        let material = SimpleMaterial(color: .red, isMetallic: true)
        let entity = ModelEntity(mesh: sphere, materials: [material])
        
        // create anchor
        anchorGlobal = AnchorEntity(plane: .any)
        
        // if position ins specified place the anchor at speciffic position
        if let anchorPos = position {
            anchorGlobal!.position.x = anchorPos.x
            anchorGlobal!.position.y = anchorPos.y
            anchorGlobal!.position.z = anchorPos.z
        }
        
        // place entity at the specified anchor
        anchorGlobal!.addChild(entity)
        
        // add anchor to the scene
        scene.addAnchor(anchorGlobal!)
    }
    
    @objc func handleScreenTap(gestureRecognizer: UIGestureRecognizer) {
        let touchLocation = gestureRecognizer.location(in: self)
        let converted3DPoint = convertPointTo3D(point: touchLocation)
        print("************* X=\(converted3DPoint.x)")
        
        // Remove the existing entity if found
        if let existingEntity = anchorGlobal {
            scene.removeAnchor(existingEntity)
        }
        
        placeEntityIntoScene(at: converted3DPoint)
        
        ////let box = MeshResource.generateBox(size: 0.1)
        //let sphere = MeshResource.generateSphere(radius: 0.1)
        //let material = SimpleMaterial(color: .blue, isMetallic: false)
        //let entity = ModelEntity(mesh: sphere, materials: [material])

        //anchorGlobal!.position.x = converted3DPoint.x
        //anchorGlobal!.position.y = converted3DPoint.y
        //anchorGlobal!.position.z = converted3DPoint.z
        //anchorGlobal!.addChild(entity)

        //scene.addAnchor(anchorGlobal!)
    }

    private func convertPointTo3D(point: CGPoint) -> SCNVector3 {
        let arPoint = self.unproject(point, viewport: frameRectGlobal)
        return SCNVector3(arPoint!.x, arPoint!.y, arPoint!.z)
    }
}
