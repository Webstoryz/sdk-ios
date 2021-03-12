//
//  Polygon.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 06.02.2021.
//

import Foundation
import SwiftUI


internal struct Polygon: Shape {
    let corners: Int
    let smoothness: CGFloat
    let rotation: CGFloat

    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        let additionalRotation = CGFloat.pi * rotation / 180
        
        var currentAngle = -CGFloat.pi / 2
        
        currentAngle += additionalRotation
        
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)
        
        let innerX = center.x * smoothness
        
        let innerY = center.y * smoothness
        
        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        var bottomEdge: CGFloat = 0
        
        for corner in 0..<corners * 2  {
            
            let sinAngle = sin(currentAngle)
            
            let cosAngle = cos(currentAngle)
            
            let bottom: CGFloat
            
            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            
            currentAngle += angleAdjustment
        }
        
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        
        return path.applying(transform)
    }
}
