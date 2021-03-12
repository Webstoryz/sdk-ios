//
//  CubeNavigation.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 08.02.2021.
//

import Foundation
import SwiftUI
import Combine

struct CubeNavigator <Content, Pages> : View where Content: View, Pages: RandomAccessCollection, Pages.Element : Identifiable {
    var pages : Pages
    var content: (Pages.Element) -> Content
    var containerSize: CGSize
    @ObservedObject var helper: CubeNavigatorHelper
    
    var cancellables = Set<AnyCancellable>()
    
    init(pages: Pages, helper: CubeNavigatorHelper, containerSize: CGSize, content: @escaping (Pages.Element) -> Content) {
        self.pages = pages
        self.content = content
        self.helper = helper
        self.containerSize = containerSize
    }
    
    func getOffsets(size: CGFloat) -> [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)] {
        var acumsize = CGFloat(0)
        var offsets = [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)]()
        var angle = CGFloat(0)
        for page in pages {
            offsets[page.id] = (acumsize, angle)
            acumsize += size
            angle = CGFloat(-90)
        }
        return offsets
    }
    
    
    func isLeftSided(position: CGFloat, width: CGFloat) -> Bool{
        if (position < 0 && position > -width ) {
            return true
        }
        return false
    }
    
    func isRightSided(position: CGFloat, width: CGFloat) -> Bool{
        if (position > 0 && position < width) {
            return true
        }
        return false
    }
    
    func getRotation(position : CGFloat, width: CGFloat) -> Double {
        let pos = position + (self.helper.translation?.width ?? 0)
        
        let sided = (self.helper.translation?.width ?? 0) > CGFloat(0) ? -1 : 1
        if (sided > 0) {
            if(isLeftSided(position: pos, width: width)) {
                return Double((self.helper.translation?.width ?? 0)/(width/90))
            }
            if(isRightSided(position: pos, width: width)) {
                return Double((self.helper.translation?.width ?? 0)/(width/90)) + 90
            }
        }else{
            if(isLeftSided(position: pos, width: width)) {
                return Double((self.helper.translation?.width ?? 0)/(width/90)) - 90
            }
            if(isRightSided(position: pos, width: width)) {
                return Double((self.helper.translation?.width ?? 0)/(width/90))
            }
        }
        
        return 0
    }
    
    func getAnchor(position : CGFloat, width: CGFloat) -> UnitPoint {
        let pos = position + self.helper.lastTranslation
        if(isLeftSided(position: pos, width: width)) {
            return .trailing
        } else {
            return .leading
        }
    }
    
    
    
    var body: some View {
        self.bodyHelper(containerSize: self.containerSize, offsets: self.getOffsets(size: containerSize.width))
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
    
    private func bodyHelper(containerSize: CGSize, offsets: [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)]) -> some View {
        ZStack {
            ForEach(self.pages){
                self.content($0).rotation3DEffect(.degrees(self.getRotation(position: (offsets[$0.id]?.position ?? 0) + self.helper.initPosition, width: containerSize.width )), axis: (x: 0, y: 1, z: 0), anchor: self.getAnchor(position: (offsets[$0.id]?.position ?? 0) + self.helper.initPosition, width: containerSize.width))
                    .offset(x: (offsets[$0.id]?.position ?? 0 ) + (self.helper.translation?.width ?? 0) + self.helper.initPosition )
                    .gesture(DragGesture()
                        .onChanged({ (value) in
                            handleGesture(value: value, containerSize: containerSize)
                        })
                        .onEnded({ (value) in
                            endAnimation(containerSize: containerSize, offsets: offsets)
                        }))
            }
            
        }
    }
    
    private func handleGesture(value: DragGesture.Value, containerSize: CGSize) {
        self.helper.translation = value.translation
        self.helper.lastTranslation = self.helper.translation?.width ?? 0
        self.helper.setInitPosition(containerSize: containerSize)
    }
    
    private func endAnimation(containerSize: CGSize, offsets: [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)]) {
        self.helper.lastTranslation = self.helper.translation?.width ?? 0
            withAnimation {
                //left
                if( self.helper.translation!.width > CGFloat(containerSize.width/2)) {
                    //checking is it on the edge
                    if ( self.helper.initPosition < 0) {
                        self.helper.translation = CGSize(width: containerSize.width, height: 0)
                        self.helper.shiftRight = true
                    } else {
                        self.helper.translation = .zero
                    }
                    
                }
                //right
                else
                    //checking is it on the edge
                if ( self.helper.translation!.width < CGFloat(-containerSize.width/2)) && (abs( self.helper.initPosition) < containerSize.width*CGFloat(offsets.count-1)) {
                        
                    self.helper.translation = CGSize(width: -containerSize.width, height: 0)
                    self.helper.shiftLeft = true
                    } else {
                        self.helper.translation = .zero
                }
                
            }
    }
}
