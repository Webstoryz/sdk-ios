//
//  CubeNavigatorHelper.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 08.02.2021.
//

import Foundation
import SwiftUI


class CubeNavigatorHelper: ObservableObject {
    @Published var shiftLeft = false
    @Published var shiftRight = false
    @Published var translation: CGSize? = nil
    @Published var initPosition = CGFloat(0)
    @Published var lastTranslation: CGFloat = 0
    @Published var angleTranslation: CGFloat = 0
    @Published var currentScreenIndex = 0
    
    
    func setInitPosition(containerSize: CGSize) {
        if(self.shiftLeft){
            self.shiftLeft = false
            self.initPosition -= containerSize.width
        }
        
        if(self.shiftRight) {
            self.shiftRight = false
            self.initPosition += containerSize.width
        }
    }
}
