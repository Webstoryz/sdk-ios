//
//  OptionalNavigationLink.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 02.03.2021.
//

import SwiftUI

struct OptionalNavigationLink: View {
    var isActive: Bool
    var destination: AnyView
    var child: AnyView
    
    
    @ViewBuilder
    var body: some View {
        if isActive {
            ViewBuilder.buildBlock(
                NavigationLink(destination: destination) {
                    self.child
                }
            )
        } else {
            ViewBuilder.buildBlock(self.child)
        }
    }
}
