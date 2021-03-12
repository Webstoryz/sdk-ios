//
//  StoryModel.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 06.02.2021.
//

import Foundation

class StoryResult: Decodable {
    var success: Bool?
    var data: StoriesData?
}

class StoriesData: Decodable {
    var stories: [StoryModel]
    var title: String?
    var style: String?
}


class StoryModel: Decodable, Identifiable {
    var subtitle: String?
    var duration: Int?
    var iconUrl: String?
    var title: String?
    var url: String?
    var id: String?
    var type: String?
    var thumbUrl: String?
    var borderColor: String?
}

extension StoryModel {
    var uuid: UUID {
        return UUID()
    }
}
