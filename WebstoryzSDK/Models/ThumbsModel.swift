//
//  ThumbsModel.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 13.02.2021.
//

import Foundation
import Combine

class ThumbsModel: ObservableObject {
    @Published var loading = true
    @Published var title: String = ""
    @Published var form: StoryThumbnailForm = .circle
    @Published var thumbs: Array<StoryModel> = []
}
