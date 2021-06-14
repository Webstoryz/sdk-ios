//
//  PreviewStory.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 05.02.2021.
//

import SwiftUI
import Combine

internal struct StoryThumbnail: View {
    
    var form: StoryThumbnailForm
    var caption:String
    var url: String
    var isButton: Bool
    var onPressed: () -> Void
    var captionStyle: TextStyle
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    init(form: StoryThumbnailForm, caption: String, url: String, isButton: Bool,captionStyle: TextStyle, onPressed: @escaping () -> Void) {
        self.form = form
        self.captionStyle = captionStyle
        self.caption = caption
        self.url = url
        self.imageLoader = ImageLoader(urlString: url)
        self.isButton = isButton
        self.onPressed = onPressed
    }
    
    var body: some View {
        OptionalButton(
            child: AnyView(
                VStack {
                    form.overlay
                        .foregroundColor(WebstoryzColors.borderColor)
                        .frame(width: form.width+5, height: form.heigth+5, alignment: .center)
                        .cornerRadius(form.cornerRadius)
                        .overlay(form.overlay
                                    .frame(width: form.width+3, height: form.heigth+3, alignment: .center)
                                    .cornerRadius(form.cornerRadius)
                                    .foregroundColor(.white)
                                    .overlay(
                                        ZStack {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width:form.width, height:form.heigth)
                                            .clipShape(form.shape())
                                            .cornerRadius(form.cornerRadius)
                                            .onReceive(imageLoader.didChange) { data in
                                                self.image = UIImage(data: data) ?? UIImage()
                                            }
                                            if form.captionInside {
                                                Text(caption).styled(style: captionStyle)
                                            }
                                        }
                                    )
                                )
                    if !form.captionInside {
                        Text(caption).styled(style: captionStyle)
                            .frame(maxWidth: form.width +3)
                    }
                }
            ),
            isActive: isButton,
            onPressed: onPressed
        )
    }
}
