//
//  TextStyle.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 14.06.2021.
//

import Foundation
import SwiftUI

public struct TextStyle {
    var color: Color
    var weight: Font.Weight
    var size: CGFloat
    var lineLimit: Int
    
    public init(color: Color = Color.black, weight: Font.Weight = .medium, size: CGFloat = 16, lineLimit: Int = 2) {
        self.color = color
        self.weight = weight
        self.size = size
        self.lineLimit = lineLimit
    }
}

public extension Text {
    func styled(style: TextStyle) -> some View {
        return self
            .font(.system(size: style.size))
            .fontWeight(style.weight)
            .lineLimit(style.lineLimit)
            .foregroundColor(style.color)
    }
}
