//
//  OptionalButton.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 20.03.2021.
//

import SwiftUI

struct OptionalButton: View {
    var child: AnyView
    var isActive: Bool
    var onPressed: () -> Void
    
    @ViewBuilder
    var body: some View {
        if isActive {
            ViewBuilder.buildBlock(
                child.onTapGesture {
                    onPressed()
                }
            )
        } else {
            ViewBuilder.buildBlock(
                child
            )
        }
    }
}
