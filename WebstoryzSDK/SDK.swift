//
//  WebstoryzSDK.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 04.02.2021.
//

import Foundation
import SwiftUI


public class SDK {
    public static func thumbs(key: String, headerStyle: TextStyle = TextStyle(), captionStyle: TextStyle = TextStyle(),leadingPadding:Int  = 0, onLoadFailed: @escaping () -> Void ) ->  some View {
        ThumbnailBlock(key: key,headerStyle: headerStyle,captionStyle: captionStyle, leadingPadding: leadingPadding, onLoadFailed: onLoadFailed)
    }
    
    public static func thumbsVC(key: String, uiController: UIViewController, headerStyle: TextStyle = TextStyle(), captionStyle: TextStyle = TextStyle(),leadingPadding:Int  = 0, onLoadFailed: @escaping () -> Void ) -> UIViewController {
        var vc: UIHostingController<ThumbnailBlock>? = nil
        var thb = ThumbnailBlock(key: key, controller: uiController, headerStyle: headerStyle, leadingPadding: leadingPadding, captionStyle: captionStyle, onLoadFailed: onLoadFailed)
        thb.setCallback {
            vc?.removeFromParent()
            vc?.view.removeFromSuperview()
        }
        vc = UIHostingController(rootView: thb);
        return vc!;
    }
    
}
