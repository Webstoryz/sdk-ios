//
//  PreviewBlock.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 05.02.2021.
//

import SwiftUI
import Combine

internal struct ThumbnailBlock: View {
    
    @ObservedObject var model = ThumbsModel()
    
    var key: String
    var controller: UIViewController?
    var callback: () -> Void?
    var captionStyle, headerStyle: TextStyle
    var onLoadFailed: () -> Void
    var leadingPadding: Int
    var showHeader: Bool
    
    init(key: String, headerStyle: TextStyle, captionStyle: TextStyle,leadingPadding: Int,showHeader: Bool, onLoadFailed: @escaping () -> Void) {
        self.captionStyle = captionStyle
        self.headerStyle = headerStyle
        self.key = key
        self.onLoadFailed = onLoadFailed
        self.leadingPadding = leadingPadding
        self.showHeader = showHeader
        self.callback =  { return }
        self.request()
    }
    
    init(key: String,controller: UIViewController, headerStyle: TextStyle,leadingPadding: Int, captionStyle: TextStyle,showHeader: Bool, onLoadFailed: @escaping () -> Void) {
        self.captionStyle = captionStyle
        self.headerStyle = headerStyle
        self.key = key
        self.onLoadFailed = onLoadFailed
        self.leadingPadding = leadingPadding
        self.controller = controller
        self.showHeader = showHeader
        self.callback =  { return }
        self.request()
    }
    
    mutating func setCallback(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    func request()  {
        try! Network.getThumbsData(key:key, callback: { storyModel in
            DispatchQueue.main.sync {
                model.form = getFormFromString(style: storyModel.data?.style ?? "")
                model.loading = false
                model.title = storyModel.data?.title ?? ""
                model.thumbs  = storyModel.data?.stories ?? []
            }
        }, errorCallback: {
            onLoadFailed()
        })
    }
    
    func getFormFromString(style: String) -> StoryThumbnailForm {
        switch style {
        case "rectangle":
            return .rectangle
        case "polygon":
            return.polygon(6)
        case "square":
            return .square
        default:
            return .circle
        }
    }
    
    ///170 is max heigth of thumb+text
    @ViewBuilder
    var body: some View {
        if self.model.loading {
            ViewBuilder.buildBlock(ActivityIndicator(isAnimating: .constant(true), style: .medium).background(Color.white).frame(height: 172))
        } else {
            ViewBuilder.buildBlock(
                        VStack(alignment: .leading) {
                            if self.model.title != "" && showHeader {
                                Text(self.model.title)
                                    .styled(style: headerStyle)
                            }
                            ScrollView(
                                .horizontal,
                                showsIndicators: false,
                                content: {
                                    HStack {
                                        Spacer()
                                            .frame(width: CGFloat(leadingPadding))
                                        ForEach(model.thumbs, id: \.uuid) { thumb in
                                            OptionalNavigationLink(
                                                isActive: self.controller == nil,
                                                destination: AnyView(StoryView(
                                                    startIndex: (model.thumbs.lastIndex(where: { val in return val.id == thumb.id }) ?? 0),
                                                    screenSize: UIScreen.main.bounds.width,
                                                    stories: self.model.thumbs
                                                )),
                                                child: AnyView(
                                                    StoryThumbnail(
                                                        form: self.model.form,
                                                        caption: thumb.title ?? "",
                                                        url: thumb.thumbUrl ?? "",
                                                        isButton: self.controller != nil,
                                                        captionStyle: self.captionStyle,
                                                        onPressed: {
                                                            let viewCtr = UIHostingController(rootView: StoryView(startIndex: model.thumbs.lastIndex(where: { val in
                                                                return val.id == thumb.id
                                                            }) ?? 0, screenSize: 375, stories: model.thumbs ))
                                                            viewCtr.view.frame = self.controller!.view.bounds
                                                            viewCtr.view.translatesAutoresizingMaskIntoConstraints = false
                                                            viewCtr.didMove(toParent: self.controller)
                                                            controller?.view.addSubview(viewCtr.view)
                                                            controller?.addChild(viewCtr)
                                                            callback()
                                                        })
                                                )
                                            )
                                        }
                                    }
                                }
                            )
                    }
                .background(Color.white)
                .frame(height: 170)
                )
            }
    }
}
