//
//  ImageLoader.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 13.02.2021.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var urlString: String
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    func load() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }

    init(urlString:String) {
        self.urlString = urlString
    }
}
