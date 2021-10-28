//
//  WebstoryzSDK.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 04.02.2021.
//

import Foundation
import SwiftUI


public class SDK {
    public static func thumbs(key: String, headerStyle: TextStyle = TextStyle(), captionStyle: TextStyle = TextStyle(),leadingPadding:Int  = 0,showHeader: Bool = true,captionType: CaptionType = CaptionType.outside, backgroundColor: Color = Color.white, onLoadFailed: @escaping () -> Void ) ->  some View {
        ThumbnailBlock(key: key,headerStyle: headerStyle,captionStyle: captionStyle, leadingPadding: leadingPadding, showHeader: showHeader,captionType: captionType,backgroundColor: backgroundColor, onLoadFailed: onLoadFailed)
    }
    
    public static func thumbsVC(key: String, uiController: UIViewController, headerStyle: TextStyle = TextStyle(), captionStyle: TextStyle = TextStyle(),leadingPadding:Int  = 0, showHeader: Bool = true,captionType: CaptionType = CaptionType.outside, backgroundColor: Color = Color.white, onLoadFailed: @escaping () -> Void ) -> UIViewController {
        var vc: UIHostingController<ThumbnailBlock>? = nil
        var thb = ThumbnailBlock(key: key, controller: uiController, headerStyle: headerStyle, leadingPadding: leadingPadding, captionStyle: captionStyle, showHeader: showHeader,captionType: captionType,backgroundColor: backgroundColor, onLoadFailed: onLoadFailed)
        thb.setCallback {
            vc?.removeFromParent()
            vc?.view.removeFromSuperview()
        }
        vc = UIHostingController(rootView: thb);
        return vc!;
    }
    
}
