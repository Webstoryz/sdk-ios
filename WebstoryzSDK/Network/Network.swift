//
//  Network.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 10.02.2021.
//

import Foundation

class Network {
    
    private init() {}
    
    static let apiUrl = "https://apiapp.webstoryz.com/2.0/widget/get-content?apiKey="
    static func getThumbsData(key:String,callback: @escaping (StoryResult) -> Void, errorCallback: @escaping() -> Void) throws {
        if key.isEmpty {
            throw SDKNWError.urlIsEmpty
        }
        let url = URL(string: apiUrl+key)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                errorCallback()
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                errorCallback()
                return
            }
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(StoryResult.self, from: data)
                    callback(decoded)
                } catch {
                    errorCallback()
                }
            }
        }
        task.resume()
//        AF.request(apiUrl+key ).responseJSON(completionHandler: { response in
//            if response.response?.statusCode != 200 {
//                errorCallback()
//                return
////            }
//            do {
//                let decoded = try JSONDecoder().decode(StoryResult.self, from: response.data!)
//                callback(decoded)
//            } catch {
//                errorCallback()
//            }
//        })
    }
}

enum SDKNWError:Error {
    case urlIsEmpty
    case invalidUrl
}
