//
//  StoryzPreviewForm.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 05.02.2021.
//

import Foundation
import SwiftUI


internal enum StoryThumbnailForm {
    case square
    case circle
    case rectangle
    case polygon(Int)
}

internal extension StoryThumbnailForm {
    @ViewBuilder
    var overlay: some View {
        switch self {
        case let .polygon(angles):
            ViewBuilder.buildBlock(Polygon(corners: angles, smoothness: CGFloat(1), rotation: 15.0))
        
        case .square:
            ViewBuilder.buildBlock (Rectangle().aspectRatio(1, contentMode: .fill))
            
        case .rectangle:
            ViewBuilder.buildBlock(Rectangle())
            
        case .circle:
            ViewBuilder.buildBlock(Circle())
        }
    }
    
    func shape() -> some Shape {
        switch self {
        case .rectangle:
            return AnyShape(Rectangle())
        case .square:
            return AnyShape(Rectangle())
        case let .polygon(angles):
            return AnyShape(Polygon(corners: angles, smoothness: CGFloat(1), rotation: 15.0))
        default:
            return AnyShape(Circle())
        }
    }
    
    var heigth: CGFloat {
        switch self {
        case .circle:
            return 108
        case .polygon(_):
            return 105
        case .rectangle:
            return 153
        case .square:
            return 116
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .rectangle:
            return 18.0
        case.square:
            return 22.0
        default:
            return 0.0
        }
    }
    
    var captionColor: Color {
        switch self {
        case .circle:
            return .black
        case  .polygon(_):
            return .black
        default:
            return .white
        }
    }
    
    var width: CGFloat {
        switch self {
        case .rectangle:
            return 114
        default:
            return self.heigth
        }
    }
    
    var id: UUID {
        return UUID()
    }
    
}
