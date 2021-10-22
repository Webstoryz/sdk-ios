//
//  CloseButton.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 21.10.2021.
//

import SwiftUI

struct CloseButton: View {
    
    var onTap: () -> Void
    
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: 30))
            .foregroundColor(Color.init(red: 81 / 255, green: 81 / 255, blue: 81 / 255))
            .background(
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color.white.opacity( 1 - 0.12))
                    .shadow(radius: 3)
            )
            .offset(x: 20, y: 30)
            .onTapGesture {
                onTap()
            }
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(onTap:  { print (1) } )
    }
}
