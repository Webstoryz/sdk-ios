//
//  ContentView.swift
//  Example
//
//  Created by Евгений Егоров on 05.02.2021.
//

import SwiftUI
import WebstoryzSDK

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    SDK.thumbs(key:"ncRB9a9SJvcpARGHY5EiWUfWDf09oKJMX0REOfyUFDZxqL0OUjFzzyqZlABlvGzt2jQwxjQN5zBZftnXLGAIKjSN6pcjLakIYM8C4jTxDXM6uVDaLVLFdIQEnsC5a18k", onLoadFailed: {
                    } )
                }}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
