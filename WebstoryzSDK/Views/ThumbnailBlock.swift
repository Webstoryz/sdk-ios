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
    
    init(key: String) {
        self.key = key
        self.callback =  { return }
        self.request()
    }
    
    init(key: String,controller: UIViewController) {
        self.key = key
        self.controller = controller
        self.callback =  { return }
        self.request()
    }
    
    mutating func setCallback(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    func request()  {
        try! Network.getThumbsData(key:key, callback: { storyModel in
            model.form = getFormFromString(style: storyModel.data?.style ?? "")
            model.loading = false
            model.title = storyModel.data?.title ?? ""
            model.thumbs  = storyModel.data?.stories ?? []
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
    
    
    @ViewBuilder
    var body: some View {
        if self.model.loading {
            ViewBuilder.buildBlock(ActivityIndicator(isAnimating: .constant(true), style: .medium).background(Color.white))
        } else {
            ViewBuilder.buildBlock(
                GeometryReader { geometry in
                        VStack(alignment: .leading) {
                            if self.model.title != "" {
                                Text(self.model.title)
                            }
                            ScrollView(
                                .horizontal,
                                showsIndicators: false,
                                content: {
                                    HStack {
                                        ForEach(model.thumbs, id: \.uuid) { thumb in
                                            OptionalNavigationLink(
                                                isActive: self.controller == nil,
                                                destination: AnyView(StoryView(
                                                    startIndex: (model.thumbs.lastIndex(where: { val in return val.id == thumb.id }) ?? 0),
                                                    screenSize: geometry.size.width,
                                                    stories: self.model.thumbs
                                                )),
                                                child: AnyView(
                                                    StoryThumbnail(
                                                        form: self.model.form,
                                                        caption: thumb.title ?? "",
                                                        url: thumb.thumbUrl ?? "",
                                                        isButton: self.controller != nil,
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
                                            
//                                            NavigationLink (
//                                                destination: StoryView(startIndex: (model.thumbs.lastIndex(where: { val in
//                                                    return val.id == thumb.id
//                                                }) ?? 0), screenSize: geometry.size.width, stories: self.model.thumbs)
//                                            ) {
//                                                StoryThumbnail(
//                                                    form: model.form,
//                                                    caption: thumb.title ?? "Null subtitle",
//                                                    url: thumb.thumbUrl ?? "",
//                                                    isButton: self.controller != nil,
//                                                    onPressed: {
//                                                        let viewCtr = UIHostingController(rootView: StoryView(startIndex: model.thumbs.lastIndex(where: { val in
//                                                            return val.id == thumb.id
//                                                        }) ?? 0, screenSize: 375, stories: model.thumbs ))
//                                                        viewCtr.view.frame = self.controller!.view.bounds
//                                                        viewCtr.view.translatesAutoresizingMaskIntoConstraints = false
//                                                        viewCtr.didMove(toParent: self.controller)
//                                                        controller?.view.addSubview(viewCtr.view)
//                                                        controller?.addChild(viewCtr)
//                                                        callback()
//                                                    }
//                                                )
//                                            }
                                        }
                                    }
                                }
                            )
                        }
                    }
                .background(Color.white)
                )
            }
    }
}
