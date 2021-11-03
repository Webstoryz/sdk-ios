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
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        print("requesting \(urlString)")
        guard let url = URL(string: urlString) else {
            print("invalid url \(urlString)")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("no data received for ulr \(urlString)")
                return
            }
            DispatchQueue.main.async {
                print("successfully received data on url \(urlString)")
                self.data = data
            }
        }
        task.resume()
    }
}
