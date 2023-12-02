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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        placeEntityIntoScene()
    }
    
    func placeEntityIntoScene() {
        // create 3D model
        let block = MeshResource.generateBox(size: 1)
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        // create anchor
        anchorGlobal = AnchorEntity(plane: .any)
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
        
        let block = MeshResource.generateBox(size: 1)
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])

        anchorGlobal!.position.x = converted3DPoint.x
        anchorGlobal!.position.y = converted3DPoint.y
        anchorGlobal!.position.z = converted3DPoint.z
        anchorGlobal!.addChild(entity)

        scene.addAnchor(anchorGlobal!)
    

        //if let hitTest = scene.hitTest(touchLocation, types: [.existingPlane]) {
        //    let hitTestResult = hitTest.first!

        //    // Remove the existing entity if found
        //    if let existingEntity = anchorEntity {
        //        scene.removeAnchor(existingEntity)
        //    }

        //    let anchor = AnchorEntity(worldTransform: hitTestResult.worldTransform)
        //    placeEntityAtAnchor(anchor: anchor, converted3DPoint: converted3DPoint)
        //} else {
        //    print("No plane found to place the anchor")
        //}
    }

    private func convertPointTo3D(point: CGPoint) -> SCNVector3 {
        let arPoint = self.unproject(point, viewport: frameRectGlobal)
        return SCNVector3(arPoint!.x, arPoint!.y, arPoint!.z)
    }

    //private func placeEntityAtAnchor(anchor: AnchorEntity, converted3DPoint: SCNVector3) {
    //    anchor.addChild(entity)

    //    // Adjust the anchor's position based on the converted 3D point
    //    anchor.position = converted3DPoint

    //    scene.addAnchor(anchor)
    //}
}
