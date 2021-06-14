//
//  Network.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 10.02.2021.
//

import Foundation
import Alamofire


class Network {
    
    private init() {}
    
    static let apiUrl = "https://apiapp.webstoryz.com/2.0/widget/get-content?apiKey="
    static func getThumbsData(key:String,callback: @escaping (StoryResult) -> Void ) throws {
        if key.isEmpty {
            throw SDKNWError.urlIsEmpty
        }
        AF.request(apiUrl+key ).responseJSON(completionHandler: { response in
            if response.response?.statusCode != 200 {
                return
            }
            do {
                let decoded = try JSONDecoder().decode(StoryResult.self, from: response.data!)
                callback(decoded)
            } catch {
                print("")
            }
        })
    }
}

enum SDKNWError:Error {
    case urlIsEmpty
    case invalidUrl
}
