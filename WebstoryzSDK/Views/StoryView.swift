//
//  StoryView.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 06.02.2021.
//

import SwiftUI
import Combine

///view that shows storys list
struct StoryView: View {
    
    let stories: [StoryModel]
    var helper = CubeNavigatorHelper()
    let delay = 0.4
    
    init(startIndex: Int, screenSize: CGFloat, stories: [StoryModel]) {
        self.helper.currentScreenIndex = startIndex
        self.helper.initPosition = CGFloat(-startIndex) * screenSize
        self.stories = stories
    }
    
    var body: some View {
        GeometryReader {    geometry in
            CubeNavigator(pages: stories, helper: self.helper, containerSize: geometry.size) { story in
                WebView(request: URLRequest(url: URL(string: story.url!)!))
            }
            .background(Color.black)
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func shiftRight(geometry: GeometryProxy){
        if self.helper.currentScreenIndex == self.stories.count - 1 {
            return
        }
        self.helper.currentScreenIndex += 1
            withAnimation {
                self.helper.translation = CGSize(width: -1, height: 0)
                self.helper.lastTranslation = -1
                self.helper.setInitPosition(containerSize: geometry.size)
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    withAnimation {
                        self.helper.translation = CGSize(width: -geometry.size.width/2, height: 0)
                        self.helper.lastTranslation = self.helper.translation?.width ?? 0
                        self.helper.setInitPosition(containerSize: geometry.size)
                    }
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    withAnimation {
                        self.helper.translation = CGSize(width: -geometry.size.width, height: 0)
                        self.helper.shiftLeft = true
                    }
                })
            }
    }
    
    func shiftLeft(geometry: GeometryProxy){
        if self.helper.currentScreenIndex == 0 {
            return
        }
        self.helper.currentScreenIndex -= 1
        withAnimation {
            self.helper.translation = CGSize(width: 1, height: 0)
            self.helper.lastTranslation = 1
            self.helper.setInitPosition(containerSize: geometry.size)
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                withAnimation {
                    self.helper.translation = CGSize(width: geometry.size.width/2, height: 0)
                    self.helper.lastTranslation = self.helper.translation?.width ?? 0
                    self.helper.setInitPosition(containerSize: geometry.size)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                withAnimation {
                    self.helper.translation = CGSize(width: geometry.size.width, height: 0)
                    self.helper.shiftRight = true
                }
            })
            
        }
    }
}
